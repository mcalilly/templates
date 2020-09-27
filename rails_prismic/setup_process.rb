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
## 5. Update the javscript/packs/application.js based on the template

yarn add alpinejs

rails db:create && rails db:migrate

# Create a basic layout using the templates
## 1. Add a shared folder for global partials
## 2. Make sure to use stylesheet_pack_tag to import CSS
### 3. Update the title and default metadata with the app name
### 4. Copy the application layout
### 5. Copy views/static/home.html.erb

rails g controller static home

# Update config/routes.rb with the template

## Create a favicon with https://realfavicongenerator.net

