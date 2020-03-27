#!/bin/bash
# iREP server - [architecture]

function brew_architecture() {

  local ENV=$1

  #Setup iREP server folder/file architecture
  echo "Brewing architecture..."

  Owner="chown $USER:$USER"
  OwnerWWW="chown $USER:www-data"
  OwnerMysql="chown $USER:mysql"


  #build commands parameters
  build="mkdir -p -v"
  perm0640="chmod 0640"
  perm0660="chmod 0660"
  perm0700="chmod 0700"
  perm0710="chmod 0710"
  perm0730="chmod 0730"
  perm0740="chmod 0740"
  perm0750="chmod 0750"
  perm0770="chmod 0770"

  #build ~/iREP-backup
  backup=/home/$USER/iREP-tmp-backup/
  $build $backup

  #Apply proper directory permission
  $perm0700 $backup

  #Apply proper directory ownership
  $Owner $backup

  #build csv/
  csv=/var/csv/
  $build $csv

  #Apply proper directory permission
  $perm0770 $csv

  #Apply proper directory ownership
  $OwnerMysql $csv

  #build /www/
  www=/var/www/
  $build $www

  #Apply proper directory permission
  $perm0750 $www

  #Apply proper directory ownership
  $OwnerWWW $www

  cd $www
  touch .htpasswd

  #Apply proper file permission
  find $www -name .htpasswd -exec $perm0740 {} \;

  #Apply proper ownership
  find $www -name .htpasswd -exec $OwnerWWW {} \;

  #build /config/ folder structure
  config=/var/www/config/
  #$build $config

  cd $config
  #touch config.ini
  #touch config.ini.bak

  #Apply proper directories permission
  find $config -type d -exec $perm0730 {} \;

  #Apply proper files permission
  find $config -type f -exec $perm0660 {} \;

  #Apply proper ownership
  find $config -exec $OwnerWWW {} \;

  #build /irep/ folder
  irep=/var/www/irep/
  $build $irep

  cd $irep
  touch .htaccess
  touch index.php

  #Apply proper directories permission
  $perm0710 $irep

  #Apply proper files permission
  $perm0640 .htaccess
  $perm0640 index.php

  #Apply proper ownership
  $OwnerWWW $irep
  $OwnerWWW .htaccess
  $OwnerWWW index.php


  #build /logs/ folder structure
  logs=/var/www/logs/
  $build $logs

  cd $logs
  touch fail.log
  touch fragmentsNotifications.log
  touch downgrading.log
  touch phpMailer.log
  touch agreementHistory.log
  touch assembler.log
  touch janitor.log
  touch mnt_network_drive.log
  touch mysqldump.log
  touch odbc-fetcher.log
  touch trailBlazer.log
  touch irep-backup.log

  #Apply proper directories permission
  find $logs -type d -exec $perm0730 {} \;

  #Apply proper files permission
  find $logs -type f -exec $perm0660 {} \;

  #Apply proper ownership
  find $logs -exec $OwnerWWW {} \;

  #iREP-toolshed folder structure & permission
  toolshed=/var/www/toolshed

  $build $toolshed/tmp/

  $build $toolshed/trailBlazer/buckets/
  $build $toolshed/trailBlazer/logs/
  $build $toolshed/trailBlazer/logs/error/
  $build $toolshed/trailBlazer/logs/purge/
  $build $toolshed/trailBlazer/logs/warning/

  #Apply proper directories permission
  find $toolshed -type d -exec $perm0700 {} \;

  #Apply proper files permission - skip over directories "/tmp" & "trailBlazer/logs"
  find $toolshed -type d -name "tmp" -prune -o -type d -name "logs" -prune -o -type f -exec $perm0700 {} \;

  #Apply proper ownership
  find $toolshed -type d -name "tmp" -prune -o -type d -name "logs" -prune -o -exec $Owner {} \;

  #build /css/ folder structure
  css=/var/www/irep/css/
  $build $css

  cd $css
  touch bootstrap.min.css
  touch contract.min.css
  touch flatpickr.min.css
  touch notie.min.css
  touch order.min.css

  #Apply proper directories permission
  find $css -type d -exec $perm0710 {} \;

  #Apply proper files permission
  find $css -type f -exec $perm0640 {} \;

  #Apply proper ownership
  find $css -exec $OwnerWWW {} \;

  #build /error_pages/ folder structure
  error_pages=/var/www/irep/error_pages/
  $build $error_pages

  cd $error_pages
  touch 404.html
  touch 500.html

  #Apply proper directories permission
  find $error_pages -type d -exec $perm0710 {} \;

  #Apply proper files permission
  find $error_pages -type f -exec $perm0640 {} \;

  #Apply proper ownership
  find $error_pages -exec $OwnerWWW {} \;

  #build /history/ folder structure
  history=/var/www/irep/history/
  $build $history

  #Apply proper directories permission
  $perm0750 $history

  #Apply proper ownership
  $OwnerWWW $history

  #build /orders/ folder structure
  orders=/var/www/irep/orders/
  $build $orders

  #Apply proper directories permission
  $perm0730 $orders

  #Apply proper ownership
  $OwnerWWW $orders

  #build /iREP/ folder structure
  iREP=/var/www/irep/iREP/
  $build $iREP

  cd $iREP
  touch app.php
  touch logout.php

  #Apply proper directories permission
  find $iREP -type d -exec $perm0710 {} \;

  #Apply proper files permission
  find $iREP -type f -exec $perm0640 {} \;

  #Apply proper ownership
  find $iREP -exec $OwnerWWW {} \;

  #build /lib/ folder structure
  lib=/var/www/irep/lib/
  $build $lib

  cd $lib
  $build auth/
  $build images/
  $build ionicons/
  $build js/
  $build logic/
  $build utils/
  $build PHPMailer/

  #build /lib/ionicons sub folders
  cd ionicons/
  $build fonts/

  #Create empty files related to /lib/auth
  cd ../auth/
  touch PasswordHash.php

  #Create empty files related to /lib/images
  cd ../images/
  touch favicon.ico
  touch irep_logo.png

  #Create empty files related to /lib/ionicons
  cd ../ionicons/
  touch ionicons.css
  touch ionicons.min.css

  #Create empty files related to /lib/ionicons/fonts
  cd fonts/
  touch ionicons.eot
  touch ionicons.svg
  touch ionicons.ttf
  touch ionicons.woff

  #Create empty files related to /lib/js
  cd ../../js/
  touch api.min.js
  touch client.min.js
  touch flatpickr.min.js
  touch list.min.js
  touch modules.min.js
  touch notie.min.js

  #Create empty files related to /lib/utils
  cd ../utils/
  touch unbox.php
  touch mailman.php
  touch repo.php
  touch db.php
  touch handshake.php
  touch cacheBuster.php
  touch snitch.php
  touch passwordMinimumStrength.php
  touch passphrase.php
  touch array_key_first.php
  touch getSMTP.php
  touch permission.php
  touch redirect.php
  touch url_handler.php
  touch log_failed_auth.php
  touch permission_check.php
  touch notify.php
  touch fail.php
  touch debugMode.php
  touch getPost.php
  touch kill_session.php
  touch customDraw.php
  touch odbc.php
  touch in_array_r.php

  #Create empty files related to /lib/ionicons
  cd ../PHPMailer/
  touch class.phpmailer.php
  touch class.pop3.php
  touch class.smtp.php
  touch PHPMailerAutoload.php

  #Apply proper directories permission
  find $lib -type d -exec $perm0710 {} \;

  #Apply proper files permission
  find $lib -type f -exec $perm0640 {} \;

  #Apply proper ownership
  find $lib -exec $OwnerWWW {} \;

  #build /logic/ folder structure
  logic=/var/www/irep/lib/logic/

  cd $logic
  $build candidate/
  $build cruising/
  $build businessLogic/
  $build coreLogic/

  #build /logic/cruising sub folders
  cd cruising/
  $build add/
  $build admin-toolbox/
  $build admin-user-maintenance/
  $build auth/
  $build create/
  $build delete/
  $build find/
  $build get/
  $build update/

  #build /logic/businessLogic sub folders
  cd ../businessLogic/
  $build dataset/
  $build repo/
  $build guards/
  $build io/
  $build modules/

  #build /logic/coreLogic sub folders
  cd ../coreLogic/
  $build dataset/
  $build odbc/
  $build repo/
  $build guards/
  $build io/

  #Create empty files related to /logic/cruising
  cd ../cruising/

  cd add/
  touch admin-motd-new-message.php
  touch favorite.php
  touch order.php

  cd ../admin-toolbox/
  touch admin-server-maintenance.php
  touch admin-test-odbc.php
  touch admin-agreement-configuration.php
  touch admin-view-user-details.php

  cd ../admin-user-maintenance/
  touch admin-add-user-favorite.php
  touch admin-delete-user-favorite.php
  touch admin-enable-disable-user.php
  touch admin-update-user-password.php
  touch admin-update-user-territories-filter.php

  cd ../auth/
  touch handshake.php

  cd ../create/
  touch admin-new-user.php
  touch order-preview.php

  cd ../delete/
  touch admin-motd-delete-message.php
  touch favorite.php

  cd ../find/
  touch customers-search.php
  touch privileged-order-center-search.php

  cd ../get/
  touch admin-maintenance-status.php
  touch admin-territories-filter.php
  touch agreement-history.php
  touch agreement-products.php
  touch customer-accounts.php
  touch customer-orders-history.php
  touch favorites.php
  touch motd.php
  touch privileged-order-center-fetch-po.php
  touch agreement-notification.php

  cd ../update/
  touch admin-motd-update-importance.php
  touch admin-update-agreement-configuration.php
  touch privileged-order-center-cancel-order.php
  touch privileged-order-center-submit-po.php

  #Create empty files related /logic/businessLogic
  cd $logic/businessLogic/

  cd dataset/
  touch build_userTerritoriesFilter.php
  touch build_iREP_purchaseOrderNumber.php
  touch build_string_stripAccents.php
  touch build_iREP_orderSheet.php
  touch build_order_TotalQty_TotalPrice.php
  touch build_orderStatus.php
  touch build_purgedArray_byValues.php
  touch build_purgedArray_byKeys.php
  touch build_purgeList_byValues.php
  touch build_purgeList_byKeys.php
  touch build_purge_history.php
  touch build_agreementConfiguration.php
  touch build_orderCenter_searchParam.php
  touch build_orderCenter_searchFilter.php
  touch build_orderCenter_orderBy_clause.php
  touch build_warehouse_location.php
  touch build_is_specialOrder_product.php
  touch build_new_order_email.php

  cd ../repo/
  touch select_active_related_customer_accounts.php
  touch select_customerDetails_by_customerName.php
  touch select_customerDetails_by_customerAccount.php
  touch select_product_agreementDetails.php
  touch select_userDetails_by_userEmail.php
  touch select_invalid_products.php
  touch select_agreementDetails.php
  touch insert_order.php
  touch update_customerDetails_latestOrder.php
  touch insert_agreement_routeFlag.php
  touch insert_agreement_historyTracking.php
  touch insert_agreement_notification.php
  touch select_agreementDetails_by_routeFlag.php
  touch select_agreementDetails_by_historyTracking.php
  touch select_agreementDetails_by_notification.php
  touch select_agreement_historyTrackingPath.php
  touch select_customerDetails_by_userInput.php
  touch select_agreement_products.php
  touch select_customer_ordersHistory.php
  touch update_orderCount.php
  touch select_gp1070_purchaseOrderNumber.php
  touch insert_orderSheetNote_gp1070_queue.php
  touch insert_special_instruction_gp1070_queue.php
  touch insert_detail_line_gp1070_queue.php
  touch select_fixed_location_products.php

  cd ../guards/
  touch is_agreementConfiguration.php
  touch is_AS400_PO.php
  touch is_customerRoute.php
  touch is_orderStatus.php
  touch is_AS400_account.php
  touch is_orderNumField.php
  touch is_warehouse_location.php
  touch is_agreementRoute.php

  cd ../io/
  touch io_iREP_orderSheet_to_HTML.php
  touch io_iREP_orderSheet_to_PDF.php

  cd ../modules/
  touch create_order.php
  touch regular_order.php
  touch special_order.php
  touch gp1070_order.php
  touch gp1070_queue.php

  #Create empty files related to /logic/coreLogic
  cd $logic/coreLogic/

  cd dataset/
  touch build_filteredArray_byValue.php
  touch build_flattenArray.php
  touch build_agreementHistory.php
  touch build_agreementHistory_template.php
  touch build_array_map_assoc.php
  touch build_areaCode_phoneNumber_from_ulink.php
  touch build_phoneNumber_queryFormat.php
  touch build_iREP_orderSheet_URL.php
  touch build_string_explode_multiDelimiters.php

  cd ../odbc/
  touch select_AS400_customers.php
  touch select_AS400_agreementHeaders.php
  touch select_AS400_agreementDetails.php
  touch select_AS400_products.php
  touch select_AS400_pricing.php
  touch select_WMS_locations.php

  cd ../repo/
  touch select_trackedAgreement.php
  touch select_agreementHistory.php
  touch update_trackedAgreement_path.php
  touch select_userLoginDetails_by_userEmail.php
  touch select_defaultFavorite_by_userEmail.php
  touch select_motd.php
  touch delete_favorite.php
  touch select_favoriteDetails_by_userEmail.php
  touch select_favoriteDetails_by_ulink.php
  touch insert_sales.php
  touch delete_gp1070_queue.php
  touch delete_agreementHistory.php
  touch insert_favorite.php
  touch insert_motd.php
  touch update_favoriteDetails.php
  touch update_userDetails.php
  touch select_territories_filter.php
  touch insert_userDetails.php
  touch delete_motd.php
  touch update_motd.php
  touch select_orderDetails.php
  touch update_orderDetails_status.php
  touch update_orderDetails.php
  touch select_orderPO.php
  touch insert_AS400_customers.php
  touch insert_AS400_agreementHeaders.php
  touch insert_AS400_agreementDetails.php
  touch insert_AS400_products.php
  touch insert_AS400_pricing.php
  touch insert_WMS_locations.php
  touch delete_outdated_records.php
  touch select_agreement_notification.php

  cd ../guards/
  touch is_empty.php
  touch is_matching_count_arrays.php
  touch is_multi_array.php
  touch is_validDateTimeString.php
  touch is_letter.php
  touch is_digit.php
  touch is_email.php
  touch is_password.php
  touch is_favoriteID.php
  touch is_ulink.php
  touch is_binary.php
  touch is_userName.php
  touch is_iREP_purchaseOrderNumber.php
  touch is_phoneNumber.php

  cd ../io/
  touch io_agreementHistory_to_HTML.php
  touch io_createFolder.php
  touch io_snitch_array.php
  touch io_unlinkFile.php
  touch io_snitch.php
  touch io_setFilePermission.php

  #Apply proper directories permission
  find $logic -type d -exec $perm0710 {} \;

  #Apply proper files permission
  find $logic -type f -exec $perm0640 {} \;

  #Apply proper ownership
  find $logic -exec $OwnerWWW {} \;

  #build /reporting/ folder structure
  reporting=/var/www/irep/reporting/
  $build $reporting

  cd $reporting
  $build pricing
  $build products
  touch .htaccess

  #Apply proper directories permission
  find $reporting -type d -exec $perm0750 {} \;

  #Apply proper files permission
  $perm0640 .htaccess

  #Apply proper ownership
  $OwnerWWW $reporting
  $OwnerWWW pricing/
  $OwnerWWW products/


  cd ~/ && echo "The architecture for ENV : $ENV has been successfully created"

}
