window.addEventListener("turbolinks:load", function () {
    const removeEls = document.querySelectorAll('.labels .remove');

    for (let removeEl of removeEls) {
        removeEl.addEventListener('ajax:success', function () {
            removeEl.parentElement.parentElement.remove();
        })
    }
})
