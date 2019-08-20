package main

import (
	"fmt"
	"os"
	"runtime"

	"github.com/haozibi/zlog"
)

func main() {

	zlog.NewBasicLog(os.Stdout)

	fmt.Println(os.UserCacheDir())
	fmt.Println(os.Hostname())
	fmt.Println(os.UserHomeDir())

	fmt.Println("=>", os.Environ())
	fmt.Println("=>", os.TempDir())
	fmt.Println("=>", runtime.Version())
	fmt.Println("=>", runtime.Compiler)
	fmt.Println("=>", runtime.GOOS)
	fmt.Println("=>", runtime.GOARCH)

	zlog.ZInfo().Msg("Run Success")
}
