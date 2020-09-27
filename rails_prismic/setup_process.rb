# Documenting the steps I take when creating a new Rails App with Prismic and use TailwindCSS
 

rails new app_name --database=postgresql

# paste in gitignore template from github
bundle install

git add -A

git commit -m "Install rails"

# Then create a new github repo
git remote add origin https://github.com/mcalilly/app_name.git

git push origin master

bundle install

yarn add tailwindcss@latest

git add -A

git commit -m "Install Tailwind CSS"

yarn add @tailwindcss/ui

# Add tailwind stylesheets
## 1. add javascript/stylesheets folder
## 2. add stylesheets/application.scss based on template
## 3. Make sure tailwind imports are included and import any components needed
## 4. Update Rails.root/postcss.config.js to match the template

rails db:create && rails db:migrate

