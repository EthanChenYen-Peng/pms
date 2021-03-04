window.addEventListener("DOMContentLoaded", function () {
    const labels = document.getElementsByClassName('labels');
    if (labels.length > 0) {
        const removeEls = labels[0].getElementsByClassName('remove');

        for (let removeEl of removeEls) {
            removeEl.addEventListener('ajax:success', function () {
                removeEl.parentElement.parentElement.remove();
            })
        }
    }
})
