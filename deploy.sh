git pull origin master

cp -R ./api /var/www/html/clubs

cd public

npm install
bower install
gulp make

cd ..

cp -R ./public/build /var/www/html/clubs
