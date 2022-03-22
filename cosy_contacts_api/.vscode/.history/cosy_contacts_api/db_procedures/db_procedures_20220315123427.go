package dbprocedures

import (
	"database/sql"

	"cosysoft.ru/cosy_contacts_api/types"
)

func GetAllGroups(conn *sql.DB) ([]types.Group, error) {
	rows, err := conn.Query("select * from groups")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

}
