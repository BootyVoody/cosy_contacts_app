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
	DateOfBirth            string  `json:"date_of_birth"`
	Age                    int     `json:"age"`
	AreaOfResidence        *string `json:"area_of_residence"`
	ActualPlaceOfResidence *string `json:"actual_place_of_residence"`
	PlaceOfResidence       *string `json:"place_of_residence"`
	CorporateCosyEmail     string  `json:"corporate_cosy_email"`
	CorporateGmailEmail    string  `json:"corporate_gmail_email"`
	PersonalEmail          *string `json:"personal_email"`
	Skype                  *string `json:"skype"`
	VK                     *string `json:"vk"`
}
