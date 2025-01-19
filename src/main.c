#include <gtk/gtk.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>

#include "gio/gio.h"
#include "glib-object.h"
#include "glib.h"
#include "gtk/gtkshortcut.h"

static void activate(GtkApplication* app, const gpointer user_data) {
    // creates a new window
    const GtkWidget* window = gtk_application_window_new(app);
    gtk_window_set_title(GTK_WINDOW(window), "quick-notes");
    gtk_window_set_default_size(GTK_WINDOW(window), 600, 800);

    // finally, present the window
    gtk_window_present(GTK_WINDOW(window));
}

// entry point of the application
int32_t main(int32_t argc, char** argv) {
    // define the application
    GtkApplication* app = gtk_application_new("com.github.thepigeongenerator.quick-notes", G_APPLICATION_DEFAULT_FLAGS);

    // connect singals
    g_signal_connect(app, "activate", G_CALLBACK(activate), NULL);

    // execute
    int32_t status = g_application_run(G_APPLICATION(app), argc, argv);
    g_object_unref(app);
    return status;
}
