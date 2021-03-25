import {Controller} from 'stimulus'
import Rails from '@rails/ujs'

export default class extends Controller {

    destroy(event) {
        const wrapper = event.target.closest('.label');
        const labelId = wrapper.dataset['labelId']
        const projectId = wrapper.dataset['labelProjectId']
        const urlTarget = `/projects/${projectId}/labels/${labelId}`

        Rails.ajax({
            url: urlTarget,
            type: "DELETE",
            dataType: 'json',
            success: resp => {
                wrapper.remove()
                let evt = new CustomEvent('updateProjectLabels', {'detail': {'label_str': resp['label_str']}});
                document.dispatchEvent(evt);
            },
            error: err => {
                console.log(err);
            },
        });
    }
}
