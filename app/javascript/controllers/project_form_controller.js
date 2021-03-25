import {Controller} from 'stimulus'

export default class extends Controller {
    static targets = ['labelsDisplayed']

    updateLabels(event) {
        const labels = event.detail.label_str
        this.labelsDisplayedTarget.value = labels
    }
}
