#!/bin/bash

# Ekran görüntülerinin kaydedileceği dizin
SCREENSHOTS_DIR="../assets/screenshots"

# Dizin yoksa oluştur
mkdir -p $SCREENSHOTS_DIR

# Uygulamayı başlat ve ekran görüntülerini al
flutter run \
  --screenshot=$SCREENSHOTS_DIR/home_screen.png \
  --screenshot=$SCREENSHOTS_DIR/categories.png \
  --screenshot=$SCREENSHOTS_DIR/search.png \
  --screenshot=$SCREENSHOTS_DIR/product_detail.png \
  --screenshot=$SCREENSHOTS_DIR/reviews.png \
  --screenshot=$SCREENSHOTS_DIR/cart.png \
  --screenshot=$SCREENSHOTS_DIR/favorites.png \
  --screenshot=$SCREENSHOTS_DIR/profile.png \
  --screenshot=$SCREENSHOTS_DIR/addresses.png \
  --screenshot=$SCREENSHOTS_DIR/notifications.png \
  --screenshot=$SCREENSHOTS_DIR/checkout.png \
  --screenshot=$SCREENSHOTS_DIR/payment.png \
  --screenshot=$SCREENSHOTS_DIR/light_theme.png \
  --screenshot=$SCREENSHOTS_DIR/dark_theme.png

# GIF oluştur
convert -delay 100 -loop 0 \
  $SCREENSHOTS_DIR/home_screen.png \
  $SCREENSHOTS_DIR/product_detail.png \
  $SCREENSHOTS_DIR/cart.png \
  $SCREENSHOTS_DIR/checkout.png \
  $SCREENSHOTS_DIR/app_preview.gif

echo "Ekran görüntüleri başarıyla kaydedildi: $SCREENSHOTS_DIR" 