package main

import (
	"fmt"
	"os"
	"runtime"

	"github.com/haozibi/zlog"
)

func main() {

	f := fibonacci()
	for i := 0; i < 40; i++ {
		fmt.Println(f())
	}

	showInfo()
}

func fibonacci() func() int {
	a, b := -1, 1
	return func() int {
		a, b = b, a+b
		return b
	}
}

func showInfo() {
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
