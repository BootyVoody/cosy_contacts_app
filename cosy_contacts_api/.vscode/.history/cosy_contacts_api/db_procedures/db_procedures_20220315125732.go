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
	rows, err := conn.Query("select id, name from subgroups where parent_id = ?", groupId)
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

func GetShortenedContactsBySubgroupId(conn *sql.DB, subgroupId string) ([]types.ShortenedContact, error) {
	rows, err := conn.Query("select id, service_name, partner_name, partner_tel from contacts where parent_id = ?", subgroupId)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var contacts []types.ShortenedContact
	for rows.Next() {
		var contact types.ShortenedContact

		if err = rows.Scan(
			&contact.Id,
			&contact.ServiceName,
			&contact.PartnerName,
			&contact.PartnerTel,
		); err != nil {
			return nil, err
		}

		contacts = append(contacts, contact)
	}
	if err = rows.Err(); err != nil {
		return nil, err
	}

	return contacts, nil
}

func GetContactById(conn *sql.DB, id string) (types.Contact, error) {
	var contact types.Contact

	if err := conn.
		QueryRow("select * from contacts where id = ?", id).
		Scan(
			&contact.Id,
			&contact.ParentId,
			&contact.ServiceName,
			&contact.PartnerName,
			&contact.PartnerTel,
			&contact.PartnerEmail,
			&contact.PartnerMessenger,
			&contact.Comment,
		); err != nil {

	}
}
