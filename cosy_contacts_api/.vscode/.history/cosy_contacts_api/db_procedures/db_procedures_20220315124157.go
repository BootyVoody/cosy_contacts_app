package dbprocedures

import (
	"database/sql"

	"cosysoft.ru/cosy_contacts_api/types"
)

func GetGroups(conn *sql.DB) ([]types.Group, error) {
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
	rows, err := conn.Query("select * from subgroups where parent_id = ?", groupId)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var subgroups []types.Subgroup
	for rows.Next() {
		var subgroup types.Subgroup

		if err = rows.Scan(
			&subgroup.Id,
			&subgroup.Name,
			new(int),
		); err != nil {
			return nil, err
		}

		subgroups = append(subgroups, subgroup)
	}
	if err = rows.Err(); err != nil {
		return nil, err
	}

	return subgroups, nil
}

func GetShortenedContacts(conn *sql.DB)
