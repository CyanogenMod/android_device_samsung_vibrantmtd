## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := Vibrant

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/vibrantmtd/full_vibrantmtd.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := vibrantmtd
PRODUCT_NAME := cm_vibrantmtd
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SGH-T959

# Build fingerprint / ID / Product name etc.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=SGH-T959 TARGET_DEVICE=SGH-T959 BUILD_FINGERPRINT=Samsung/SGH-T959/SGH-T959/SGH-T959:2.2/FROYO/UVKB5:user/release-keys PRIVATE_BUILD_DESC="SGH-T959-user 2.2 FROYO UVKB5 release-keys"
