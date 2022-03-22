package dbprocedures

import "database/sql"

func GetAllGroups(conn *sql.DB) (*sql.Rows, error) {
	return conn.Query("select * from groups")
}
