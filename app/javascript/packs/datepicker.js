import flatpickr from 'flatpickr'
import 'flatpickr/dist/flatpickr.min.css'

document.addEventListener('turbolinks:load', function () {
    flatpickr("#project_due_date", {
        enableTime: true,
        minDate: 'today'
    })

    flatpickr("#project_start_date", {
        enableTime: true,
        minDate: 'today'
    })
})
