Phoenix.set({
    daemon: true,
    openAtLogin: true,
});

// unique identifier of screens, can be obtained from `displayplacer list`
const leftScreenId = "37D8832A-2D66-02CA-B9F7-8F30A301B230";
const midScreenId = "08C153AD-75E3-44CE-948A-26CA0346FA3C";
const rightScreenId = "E27ED4C0-F62A-4359-9E3E-C29873EAE0BF";

// app screen allocation configuration
const config = new Map();
config[leftScreenId] = ["Mail", "Reminders", "Calendar", "Spotify"];
config[midScreenId] = ["Safari", "WezTerm"];
config[rightScreenId] = ["Firefox", "Telegram"];

Event.on("screensDidChange", () => {
    // get all screen visible frames
    let frames = new Map();
    for (screen of Screen.all()) {
        frames.set(screen.identifier(), screen.visibleFrame());
    }

    // move all windows of an app to a specified screen
    function setWindowScreen(appName, screenId) {
        const app = App.get(appName);
        if (app === undefined) return;

        const frame = frames.get(screenId);
        if (frame === undefined) return;

        for (win of app.windows()) {
            win.setFrame(frame);
            win.maximize();
        }
    }

    // apply config
    for (const [screen, apps] of Object.entries(config)) {
        for (const app of apps) {
            setWindowScreen(app, screen);
        }
    }
});
