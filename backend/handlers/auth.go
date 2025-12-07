package handlers

import (
	"net/http"

	"skillmatch-backend/config"
	"skillmatch-backend/models"
	"skillmatch-backend/utils"

	"github.com/labstack/echo/v4"
	"golang.org/x/crypto/bcrypt"
)

type RegisterRequest struct {
	Name      string `json:"name"`
	Email     string `json:"email"`
	Password  string `json:"password"`
	Location  string `json:"location"`
	MainSkill string `json:"main_skill"`
}

func Register(c echo.Context) error {
	var req RegisterRequest

	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{"error": err.Error()})
	}

	passwordHash, _ := bcrypt.GenerateFromPassword([]byte(req.Password), bcrypt.DefaultCost)

	user := models.User{
		Name:      req.Name,
		Email:     req.Email,
		Password:  string(passwordHash),
		Location:  req.Location,
		MainSkill: req.MainSkill,
	}

	if err := config.DB.Create(&user).Error; err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{"error": err.Error()})
	}

	token, _ := utils.GenerateToken(user.ID)

	return c.JSON(http.StatusOK, echo.Map{
		"access_token": token,
		"user":         user,
	})
}

type LoginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

func Login(c echo.Context) error {
	var req LoginRequest

	if err := c.Bind(&req); err != nil {
		return c.JSON(http.StatusBadRequest, echo.Map{"error": err.Error()})
	}

	var user models.User
	if err := config.DB.Where("email = ?", req.Email).First(&user).Error; err != nil {
		return c.JSON(http.StatusUnauthorized, echo.Map{"error": "Email tidak ditemukan"})
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(req.Password)); err != nil {
		return c.JSON(http.StatusUnauthorized, echo.Map{"error": "Password salah"})
	}

	token, _ := utils.GenerateToken(user.ID)

	return c.JSON(http.StatusOK, echo.Map{
		"access_token": token,
		"user":         user,
	})
}
