// const room_id = document.getElementById('room_id').value
// fetch('/realtime_info?room_id=' + room_id).then((response) => {
//     return response.json()
// }).then((data) => {
// })
import Rails from "@rails/ujs"

const room_id = document.getElementById('room_id').value
const player_detail = document.getElementById('player_detail').value
setInterval(() => {
    Rails.ajax({
        url: '/realtime_info',
        type: 'get',
        success: () => {
            window.location.href = '/playing?room_id=' + room_id + '&player_detail=' + player_detail
        },
        error: () => {
            console.log("failed")
        }
    })
}, 5000)
