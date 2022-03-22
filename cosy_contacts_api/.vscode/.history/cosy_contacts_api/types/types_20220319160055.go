package types

type Group struct {
	Id       int    `json:"id"`
	Name     string `json:"name"`
	ImageUrl string `json:"imageUrl"`
}

type Subgroup struct {
	Id       int    `json:"id"`
	Name     string `json:"name"`
	ImageUrl string `json:"imageUrl"`
}

type ShortenedContact struct {
	Id          int    `json:"id"`
	ServiceName string `json:"serviceName"`
	PartnerName string `json:"partnerName"`
	PartnerTel  string `json:"partnerTel"`
}

type Contact struct {
	Id               int     `json:"id"`
	ParentId         int     `json:"parentId"`
	ServiceName      string  `json:"serviceName"`
	PartnerName      string  `json:"partnerName"`
	PartnerTel       string  `json:"partnerTel"`
	PartnerEmail     *string `json:"partnerEmail"`
	PartnerMessenger *string `json:"partnerMessenger"`
	Comment          *string `json:"comment"`
}

type ShortenedEmployee struct {
	Id       int    `json:"id"`
	Fullname string `json:"fullname"`
	Tel      string `json:"tel"`
}

type Employee struct {
	Id                     int     `json:"id"`
	Fullname               string  `json:"fullname"`
	Tel                    string  `json:"tel"`
	DateOfBirth            string  `json:"dateOfBirth"`
	Age                    int     `json:"age"`
	AreaOfResidence        *string `json:"areaOfResidence"`
	ActualPlaceOfResidence *string `json:"actualPlaceOfResidence"`
	PlaceOfResidence       *string `json:"placeOfResidence"`
	CorporateCosyEmail     string  `json:"corporateCosyEmail"`
	CorporateGmailEmail    string  `json:"corporateGmailEmail"`
	PersonalEmail          *string `json:"personalEmail"`
	Skype                  *string `json:"skype"`
	VK                     *string `json:"vk"`
}
