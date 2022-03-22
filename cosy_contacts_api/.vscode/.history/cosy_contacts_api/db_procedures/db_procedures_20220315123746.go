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

	var groups []types.Group
	for rows.Next() {
		var group types.Group

		if err = rows.Scan(
			&group.Id,
			&group.Name,
		); err != nil {
			return nil, err
		}

		groups = append(groups, group)
	}
	if err = rows.Err(); err != nil {
		return nil, err
	}

	return groups, nil
}

func GetSubgroupsByGroupId(conn *sql.DB, groupId string) ([]types.Subgroup, error) {

}
