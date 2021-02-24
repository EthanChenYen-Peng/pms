window.addEventListener("DOMContentLoaded", function () {
    const labels = document.getElementsByClassName('labels');
    const removeEls = labels[0].getElementsByClassName('remove');

    for (let removeEl of removeEls) {
        removeEl.addEventListener('ajax:success', function () {
            removeEl.parentElement.parentElement.remove();
        })
    }
})
