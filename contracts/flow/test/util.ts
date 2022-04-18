import * as _ from "lodash";

export function expectEvent(name, txResult, data) {
    const found = txResult.events.some((e) => e.type.endsWith(name) && _.isMatch(e.data, data));
    if (!found) {
        throw new Error(`Event ${name} not found: ${JSON.stringify(data)}`);
    }
}

export function expectNoEvent(name, txResult) {
    const found = txResult.events.some((e) => e.type.endsWith(name));
    if (found) {
        throw new Error(`Event ${name} was found!`);
    }
}
