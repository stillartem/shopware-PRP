#!/usr/bin/env bash

source $(dirname "$0")/functions.sh

if envFileDoesNotExists
   then
      echo -e "\nHi there! We need to configure your shop before proceeding any further, please complete the following fields\n"
      createEnvFileInteractive
fi

loadEnvFile

if firstInstallNotDone
   then
      swCommand sw:database:setup --steps=drop,create,import
      echo "Importing demo data please wait..."
      swCommand sw:database:setup --steps=setupShop --shop-url="$SHOP_URL"
      swCommand sw:theme:initialize
      swCommand sw:firstrunwizard:disable
      swCommand sw:admin:create --name="demo" --email="demo@demo.com" --username="demo" --password="demo" -n
      swCommand sw:snippets:to:db --include-plugins
      curl -L "http://releases.s3.shopware.com/test_images_since_5.1.zip" > images.zip && unzip -n images.zip && rm images.zip
      ${__DIR__}/post-install.sh

   else
        ${__DIR__}/post-update.sh
        exit 0
fi