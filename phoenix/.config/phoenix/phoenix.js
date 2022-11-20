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

const DISPLAYCER_PATH = "/opt/homebrew/bin/displayplacer";

// apply stored layout
function applyLayout() {
    const layout = Storage.get(getScreenLayoutKey());
    if (layout === undefined) return;

    // apply screen arrangement
    Task.run(DISPLAYCER_PATH, layout.screenArrangement);

    // apply window positions
    for (const win of Window.all({ visible: true })) {
        win.setFrame(layout.windowPositions[win.hash()]);
    }
}

// "⌘⌃⇧ + d" to apply layout
Key.on("d", ["command", "control", "shift"], () => {
    applyLayout();
});
