package main

import (
	"database/sql"
	"fmt"
	"os"

	_ "github.com/mattn/go-sqlite3"
)

type Contact struct {
	Id       int `json:"id"`
	ParentId int `json:"parent_id"`
}

func main() {
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

	for rows.Next() {

	}
}
