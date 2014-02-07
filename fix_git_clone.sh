#!/bin/sh

data_dir=$1

find $data_dir -name ".git" -not -path "*/.bundle/*" -exec sh -c "cd {}/.. && git checkout master && git checkout ." {} \;

