package main

import (
	"github.com/rha-fxcode/rha-fxcode/cmd"
	"github.com/rha-fxcode/rha-fxcode/internal/logging"
)

func main() {
	defer logging.RecoverPanic("main", func() {
		logging.ErrorPersist("Application terminated due to unhandled panic")
	})

	cmd.Execute()
}
