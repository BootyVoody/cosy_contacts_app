package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"

	_ "github.com/mattn/go-sqlite3"
)

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

type Group struct {
	Id   int    `json:"id"`
	Name string `json:"name"`
}

type Subgroup struct {
	Id       int    `json:"id"`
	ParentId int    `json:"parent_id"`
	Name     string `json:"name"`
}

type Contact struct {
	Id               int     `json:"id"`
	ParentId         int     `json:"parent_id"`
	ServiceName      string  `json:"service_name"`
	PartnerName      string  `json:"partner_name"`
	PartnerTel       string  `json:"partner_tel"`
	PartnerEmail     *string `json:"partner_email"`
	PartnerMessenger *string `json:"partner_messenger"`
}

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

func main() {
	http.HandleFunc("/api/v1/contacts/get", getContacts)

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

func getContacts(rw http.ResponseWriter, r *http.Request) {
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

	rows, err := dbConn.Query("select * from contacts")
	if err != nil {
		logError("Query error: " + err.Error())
		http.Error(rw, "", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var contacts []Contact
	for rows.Next() {
		var contact Contact

		if err = rows.Scan(
			&contact.Id,
			&contact.ParentId,
			&contact.ServiceName,
			&contact.PartnerName,
			&contact.PartnerTel,
			&contact.PartnerEmail,
			&contact.PartnerMessenger,
		); err != nil {
			logError("Query scanning error: " + err.Error())
			http.Error(rw, "", http.StatusInternalServerError)
			return
		}

		contacts = append(contacts, contact)
	}
	if rows.Err() != nil {
		logError("Rows error: " + err.Error())
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
