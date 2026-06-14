#!/bin/bash

g_var="I Am Global Variable"

greet(){
        local l_var="I Am Local"
        f_var="Variable"
        echo "$l_var + $g_var"
}


echo "Before calling the greet function: $l_var+ $f_var + $g_var"
echo ""

greet

echo""
echo "After calling the greet function: $l_var + $f_var + $g_var"         
