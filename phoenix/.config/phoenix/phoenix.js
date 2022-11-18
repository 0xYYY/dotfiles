const { execSync } = require("child_process");

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

    // set screen arrangement
    if (frames.has(midScreenId)) {
        execSync(
            '/opt/homebrew/bin/displayplacer "id:08C153AD-75E3-44CE-948A-26CA0346FA3C+EF65AB8A-CAA9-4AA7-9AFC-D5FD59BE7267 res:1920x1080 hz:60 color_depth:4 scaling:on origin:(0,0) degree:0" "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1470x956 hz:60 color_depth:8 scaling:on origin:(-1470,124) degree:0" "id:E27ED4C0-F62A-4359-9E3E-C29873EAE0BF res:1080x1920 hz:75 color_depth:4 scaling:off origin:(1920,-166) degree:0"'
        );
    }

    // move all windows of an app to a specified screen
    function setWindowScreen(appName, screenId) {
        const app = App.get(appName);
        if (app === undefined) return;

        const frame = frames.get(screenId);
        if (frame === undefined) {
            frame = Screen.main().frame();
        }

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
