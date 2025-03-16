window.addEventListener('message', function(event) {
    if (event.data.action === "updateScoreboard") {
        document.getElementById('player-list').innerHTML = '';
        event.data.players.forEach(player => {
            const playerDiv = document.createElement('div');
            playerDiv.innerText = `${player.name} (${player.id}) - ${player.job}`;
            document.getElementById('player-list').appendChild(playerDiv);
        });
        document.getElementById('total-players').innerText = `Total Players: ${event.data.totalPlayers}`;
        document.getElementById('police-group').innerText = `Police: ${event.data.jobs.police}`;
        document.getElementById('tuner-group').innerText = `Tuner: ${event.data.jobs.tuner}`;
        document.getElementById('ems-group').innerText = `EMS: ${event.data.jobs.ems}`;
    }

    if (event.data.action === "toggleScoreboard") {
        const scoreboard = document.getElementById('scoreboard-container');
        if (scoreboard.style.display === 'none' || scoreboard.style.display === '') {
            scoreboard.style.display = 'block';
            scoreboard.style.animation = 'slideIn 0.3s ease-out';
        } else {
            scoreboard.style.animation = 'slideOut 0.3s ease-in';
            setTimeout(() => {
                scoreboard.style.display = 'none';
            }, 300);
        }
    }
});
