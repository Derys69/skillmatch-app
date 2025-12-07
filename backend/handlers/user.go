package handlers

import (
	"net/http"

	"skillmatch-backend/config"
	"skillmatch-backend/models"

	"github.com/labstack/echo/v4"
)

func GetMe(c echo.Context) error {
	user := c.Get("user").(models.User)
	return c.JSON(http.StatusOK, user)
}

type UpdateProfileRequest struct {
	Name      string `json:"name"`
	Location  string `json:"location"`
	MainSkill string `json:"main_skill"`
}

func UpdateProfile(c echo.Context) error {
	user := c.Get("user").(models.User)

	var req UpdateProfileRequest
	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{"error": err.Error()})
	}

	config.DB.Model(&user).Updates(models.User{
		Name:      req.Name,
		Location:  req.Location,
		MainSkill: req.MainSkill,
	})

	return c.JSON(http.StatusOK, user)
}
