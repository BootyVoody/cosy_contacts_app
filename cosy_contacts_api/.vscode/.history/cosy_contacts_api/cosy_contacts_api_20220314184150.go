package main

import (
	"database/sql"
	"fmt"
	"net/http"
	"os"

	_ "github.com/mattn/go-sqlite3"
)

type Contact struct {
	Id               int     `json:"id"`
	ParentId         int     `json:"parent_id"`
	ServiceName      string  `json:"service_name"`
	PartnerName      string  `json:"partner_name"`
	PartnerTel       string  `json:"partner_tel"`
	PartnerEmail     *string `json:"partner_email"`
	PartnerMessenger *string `json:"partner_messenger"`
}

func main() {
	http.HandleFunc("/api/v1/contacts/get", getContacts)

}

func getContacts(rw http.ResponseWriter, r *http.Request) {

}

func sqlite3Tryout() {
	db, err := sql.Open("sqlite3", "cosy_contacts_api.db")
	if err != nil {
		fmt.Printf("error while opening connection to db: %v", err)
		os.Exit(-1)
	}
	defer db.Close()

	rows, err := db.Query("select * from contacts")
	if err != nil {
		fmt.Printf("error while quering to db: %v", err)
		os.Exit(-1)
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
			fmt.Printf("error while scanning the query: %v", err)
			os.Exit(-1)
		}

		contacts = append(contacts, contact)
	}
	if rows.Err() != nil {
		fmt.Printf("rows error: %v", err)
		os.Exit(-1)
	}

	fmt.Printf("contacts: %v\n", contacts)
}
