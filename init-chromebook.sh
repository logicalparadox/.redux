#!/bin/bash

INIT_DIR="$( cd "$( dirname "$0" )" && pwd )"

sh $INIT_DIR/init-env.sh
sh $INIT_DIR/.conig/init.sh
sh $INIT_DIR/init-post.sh
