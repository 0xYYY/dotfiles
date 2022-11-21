Phoenix.set({
    daemon: true,
    openAtLogin: true,
});

// generate unique key given attached screens
function getScreenLayoutKey() {
    let screenIds = Screen.all().map((s) => s.identifier());
    screenIds.sort();
    return screenIds.join("|");
}

// save current screen layout and window positions
function saveLayout() {
    Task.run("/opt/homebrew/bin/displayplacer", ["list"], (task) => {
        const stdout = task.output.trim();
        const lastIndex = stdout.lastIndexOf("\n");
        const lastLine = stdout.slice(lastIndex + 1);
        const screenArrangement = lastLine
            .split('"')
            .filter((x) => x.trim() !== "")
            .slice(1);
        Storage.set(getScreenLayoutKey(), {
            screenArrangement: screenArrangement,
            windowPositions: Object.fromEntries(
                Window.all({ visible: true }).map((w) => [w.hash(), w.frame()])
            ),
        });
    });
}

// save layout every 10 minutes
Timer.every(600, () => {
    saveLayout();
});

// "⌘⌃⇧ + s" to save layout
Key.on("s", ["command", "control", "shift"], () => {
    saveLayout();
});

const DISPLAYCER = "/opt/homebrew/bin/displayplacer";

// apply stored layout
function applyLayout() {
    const layout = Storage.get(getScreenLayoutKey());
    if (layout === undefined) return;

    // apply screen arrangement
    Task.run(DISPLAYCER, layout.screenArrangement);

    // apply window positions
    for (const win of Window.all({ visible: true })) {
        const frame = layout.windowPositions[win.hash()];
        if (frame !== undefined) win.setFrame(frame);
    }
}

// "⌘⌃⇧ + d" to apply layout
Key.on("d", ["command", "control", "shift"], () => {
    applyLayout();
});

const OPEN = "/usr/bin/open";
const PGREP = "/usr/bin/pgrep";
const PKILL = "/usr/bin/pkill";
// both the actual physical screen and dummy one should be listed
const BETTER_DISPLAY_SCREEN_IDS = [
    "08C153AD-75E3-44CE-948A-26CA0346FA3C",
    "EF65AB8A-CAA9-4AA7-9AFC-D5FD59BE7267",
];

// start/quit BetterDisplay
// NOTE: running process of BetterDisplay still shows its old name, BetterDummy
function toggleBetterDisplay() {
    // check if one of the active screen is in the configured list
    const shouldOpen = Screen.all().reduce(
        (r, s) => r || BETTER_DISPLAY_SCREEN_IDS.includes(s.identifier()),
        false
    );

    if (shouldOpen) {
        // start BetterDisplay if it's not running already
        Task.run(PGREP, ["BetterDummy"], (task) => {
            if (task.status !== 0) {
                Task.run(OPEN, ["-a", "BetterDisplay"]);
            }
        });
    } else {
        // quit BetterDisplay if none of the screens requires it
        Task.run(PKILL, ["BetterDummy"]);
    }
}

// toggle BetterDisplay when screens are (dis)connected
Event.on("screensDidChange", () => {
    toggleBetterDisplay();
});
