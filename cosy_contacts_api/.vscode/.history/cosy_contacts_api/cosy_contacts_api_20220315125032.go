package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"

	dbProcedures "cosysoft.ru/cosy_contacts_api/db_procedures"
	types "cosysoft.ru/cosy_contacts_api/types"
	_ "github.com/mattn/go-sqlite3"
)

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func main() {
	http.HandleFunc("/api/v1/groups/get", getGroups)
	http.HandleFunc("/api/v1/subgroups/get", getSubgroups)
	http.HandleFunc("/api/v1/contacts/getShortened", getShortenedContacts)
	http.HandleFunc("/api/v1/contacts/getById", getContactById)
	http.HandleFunc("/api/v1/employees/get", getEmployees)
	http.HandleFunc("/", func(rw http.ResponseWriter, r *http.Request) {
		http.Error(rw, "", http.StatusNotFound)
	})

	logInfo("Served at :3535")
	if err := http.ListenAndServe(":3535", requestLogger(http.DefaultServeMux)); err != nil {
		logError("Unable to serve at :3535")
		os.Exit(-1)
	}
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func requestLogger(h http.Handler) http.Handler {
	return http.HandlerFunc(func(rw http.ResponseWriter, r *http.Request) {
		var pathBuilder strings.Builder
		pathBuilder.WriteString(r.URL.Path)
		if len(r.URL.RawQuery) > 0 {
			pathBuilder.WriteString(fmt.Sprintf("?%s", r.URL.RawQuery))
		}
		if len(r.URL.Fragment) > 0 {
			pathBuilder.WriteString(fmt.Sprintf("#%s", r.URL.Fragment))
		}
		if xff := r.Header.Get("X-Forwarded-For"); xff != "" {
			logInfo(fmt.Sprintf("%s (XFF %s): \"%s\" %s", r.RemoteAddr, xff, r.Method, pathBuilder.String()))
		} else {
			logInfo(fmt.Sprintf("%s: \"%s\" %s", r.RemoteAddr, r.Method, pathBuilder.String()))
		}
		h.ServeHTTP(rw, r)
	})
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func getGroups(rw http.ResponseWriter, r *http.Request) {
	if r.Method != "GET" {
		http.Error(rw, "", http.StatusNotFound)
		return
	}

	dbConn, err := getDbConnection()
	if err != nil {
		logError("Database connection error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}
	defer dbConn.Close()

	groups, err := dbProcedures.GetGroups(dbConn)
	if err != nil {
		logError("Query error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}

	response, err := json.Marshal(groups)
	if err != nil {
		logError("Conversion to JSON error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}
	rw.Header().Set("Content-Type", "application/json; charset=UTF-8")
	if string(response) == "null" {
		rw.Write([]byte("[]"))
		return
	}
	rw.Write(response)
}

func getSubgroups(rw http.ResponseWriter, r *http.Request) {
	if r.Method != "GET" {
		http.Error(rw, "", http.StatusNotFound)
		return
	}

	groupId, ok := r.URL.Query()["groupId"]
	if !ok || len(groupId[0]) < 1 {
		logError("Group id was not passed")
		http.Error(rw, "", http.StatusBadRequest)
		return
	}

	dbConn, err := getDbConnection()
	if err != nil {
		logError("Database connection error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}
	defer dbConn.Close()

	subgroups, err := dbProcedures.GetSubgroupsByGroupId(dbConn, groupId[0])
	if err != nil {
		logError("Query error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}

	response, err := json.Marshal(subgroups)
	if err != nil {
		logError("Conversion to JSON error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}
	rw.Header().Set("Content-Type", "application/json; charset=UTF-8")
	if string(response) == "null" {
		rw.Write([]byte("[]"))
		return
	}
	rw.Write(response)
}

func getShortenedContacts(rw http.ResponseWriter, r *http.Request) {
	if r.Method != "GET" {
		http.Error(rw, "", http.StatusNotFound)
		return
	}

	subgroupId, ok := r.URL.Query()["subgroupId"]
	if !ok || len(subgroupId[0]) < 1 {
		logError("Subgroup id was not passed")
		http.Error(rw, "", http.StatusBadRequest)
		return
	}

	dbConn, err := getDbConnection()
	if err != nil {
		logError("Database connection error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}
	defer dbConn.Close()

	contacts, err := dbProcedures.GetShortenedContactsBySubgroupId(dbConn, subgroupId[0])
	if err != nil {
		logError("Query error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}

	response, err := json.Marshal(contacts)
	if err != nil {
		logError("Conversion to JSON error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}
	rw.Header().Set("Content-Type", "application/json; charset=UTF-8")
	if string(response) == "null" {
		rw.Write([]byte("[]"))
		return
	}
	rw.Write(response)
}

func getEmployees(rw http.ResponseWriter, r *http.Request) {
	if r.Method != "GET" {
		http.Error(rw, "", http.StatusNotFound)
		return
	}

	dbConn, err := getDbConnection()
	if err != nil {
		logError("Database connection error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}
	defer dbConn.Close()

	rows, err := dbConn.Query("select * from employees")
	if err != nil {
		logError("Query error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var employees []types.Employee
	for rows.Next() {
		var employee types.Employee

		if err = rows.Scan(
			&employee.Id,
			&employee.Fullname,
			&employee.Tel,
			&employee.DateOfBirth,
			&employee.Age,
			&employee.AreaOfResidence,
			&employee.ActualPlaceOfResidence,
			&employee.PlaceOfResidence,
			&employee.CorporateCosyEmail,
			&employee.CorporateGmailEmail,
			&employee.PersonalEmail,
			&employee.Skype,
			&employee.VK,
		); err != nil {
			logError("Query scanning error: " + err.Error())
			http.Error(rw, "", http.StatusInternalServerError)
			return
		}

		employees = append(employees, employee)
	}
	if rows.Err() != nil {
		logError("Rows error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}

	response, err := json.Marshal(employees)
	if err != nil {
		logError("Conversion to JSON error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}
	rw.Header().Set("Content-Type", "application/json; charset=UTF-8")
	if string(response) == "null" {
		rw.Write([]byte("[]"))
		return
	}
	rw.Write(response)
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func logInfo(message string) {
	log.Printf("\033[1;34m[I] %s\033[0m", message)
}

func logError(message string) {
	log.Printf("\033[1;31m[E] %s\033[0m", message)
}

func getDbConnection() (*sql.DB, error) {
	return sql.Open("sqlite3", "cosy_contacts_api.db")
}
