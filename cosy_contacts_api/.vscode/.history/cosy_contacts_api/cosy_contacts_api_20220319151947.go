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
	_ "github.com/mattn/go-sqlite3"
)

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func main() {
	wd, err := os.Getwd()
	if err != nil {
		logError("Unable to get current work directory: " + err.Error())
		os.Exit(-1)
	}

	http.Handle(
		"/static/",
		http.StripPrefix(
			"/static/",
			http.FileServer(http.Dir(wd+"/static")),
		),
	)

	http.HandleFunc("/api/v1/groups/get", getGroups)
	http.HandleFunc("/api/v1/subgroups/get", getSubgroups)
	http.HandleFunc("/api/v1/contacts/get", getShortenedContacts)
	http.HandleFunc("/api/v1/contacts/getById", getContactById)
	http.HandleFunc("/api/v1/employees/get", getShortenedEmployees)
	http.HandleFunc("/api/v1/employees/getById", getEmployeeById)
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

func getContactById(rw http.ResponseWriter, r *http.Request) {
	if r.Method != "GET" {
		http.Error(rw, "", http.StatusNotFound)
		return
	}

	contactId, ok := r.URL.Query()["contactId"]
	if !ok || len(contactId[0]) < 1 {
		logError("Contact id was not passed")
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

	contact, err := dbProcedures.GetContactById(dbConn, contactId[0])
	if err != nil {
		logError("Query error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}

	response, err := json.Marshal(contact)
	if err != nil {
		logError("Conversion to JSON error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}
	rw.Header().Set("Content-Type", "application/json; charset=UTF-8")
	rw.Write(response)
}

func getShortenedEmployees(rw http.ResponseWriter, r *http.Request) {
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

	employees, err := dbProcedures.GetShortenedEmployees(dbConn)
	if err != nil {
		logError("Query error: " + err.Error())
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

func getEmployeeById(rw http.ResponseWriter, r *http.Request) {
	if r.Method != "GET" {
		http.Error(rw, "", http.StatusNotFound)
		return
	}

	employeeId, ok := r.URL.Query()["employeeId"]
	if !ok || len(employeeId[0]) < 1 {
		logError("Contact id was not passed")
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

	employee, err := dbProcedures.GetEmployeeById(dbConn, employeeId[0])
	if err != nil {
		logError("Query error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}

	response, err := json.Marshal(employee)
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

func logDebug(message string) {
	log.Printf("\033[1;32m[D] %s\033[0m", message)
}

func getDbConnection() (*sql.DB, error) {
	return sql.Open("sqlite3", "cosy_contacts_api.db")
}
