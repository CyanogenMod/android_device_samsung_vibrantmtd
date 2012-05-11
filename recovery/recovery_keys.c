#include <linux/input.h>

#include "recovery_ui.h"
#include "common.h"
#include "extendedcommands.h"

int device_toggle_display(volatile char* key_pressed, int key_code) {
    int alt = key_pressed[KEY_LEFTALT] || key_pressed[KEY_RIGHTALT];
    if (alt && key_code == KEY_L)
        return 1;
    // allow toggling of the display if the correct key is pressed, and the display toggle is allowed or the display is currently off
    if (ui_get_showing_back_button()) {
        return 0;
        //return get_allow_toggle_display() && (key_code == KEY_HOME || key_code == KEY_MENU || key_code == KEY_END);
    }
    return get_allow_toggle_display() && (key_code == KEY_MENU || key_code == KEY_BACK);
}

int device_handle_key(int key_code, int visible) {
    if (visible) {
        switch (key_code) {
            case KEY_VOLUMEDOWN:
            case 217: // SEARCH
                return HIGHLIGHT_DOWN;

            case KEY_VOLUMEUP:
            case 139: // MENU
                return HIGHLIGHT_UP;

            case 158: // HOME
                return SELECT_ITEM;

            case 102: // BACK
                if (!get_allow_toggle_display())
                    return GO_BACK;

            case KEY_POWER:
                return SELECT_ITEM;
            default:
                return NO_ACTION;
        }
    }

    return NO_ACTION;
}
