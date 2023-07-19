bash build.sh 

if [ ! -f "custom_create.sh" ]; then
    cp create.sh custom_create.sh
fi

bash custom_create.sh