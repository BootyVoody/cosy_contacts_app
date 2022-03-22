package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"os"

	_ "github.com/mattn/go-sqlite3"
)

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

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
	if err := http.ListenAndServe(":3535", http.DefaultServeMux); err != nil {
		logError("Unable to serve at :3535")
		os.Exit(-1)
	}
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
		fmt.Printf("rows error: %v", err)
		os.Exit(-1)
	}
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
