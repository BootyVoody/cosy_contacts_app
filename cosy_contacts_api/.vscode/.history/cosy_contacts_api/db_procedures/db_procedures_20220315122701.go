package dbprocedures

import "database/sql"

func getAllGroups(conn *sql.DB) (*sql.Rows, error) {
	return conn.Query("select * from groups")
}
