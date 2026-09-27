package main

import (
      "os"

      "github.com/root-67/root-67.github.io/app"
)

func main() {
     err := app.Execute()
     if err != nil {
         os.Exit(1)
     }
}

