<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Firework with Pop-up</title>
    <style>
        body {
            background-color: black;
            margin: 0;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        canvas {
            position: absolute;
            top: 0;
            left: 0;
        }

        #popup {
            color: white;
            font-size: 3rem;
            display: none;
        }
    </style>
</head>
<body>
    <canvas id="fireworksCanvas"></canvas>
    <div id="popup">Nini</div>

    <script>
        // Firework effect
        const canvas = document.getElementById("fireworksCanvas");
        const ctx = canvas.getContext("2d");
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;

        function random(min, max) {
            return Math.random() * (max - min) + min;
        }

        function Firework(x, y) {
            this.x = x;
            this.y = y;
            this.sparks = [];

            for (let i = 0; i < 100; i++) {
                this.sparks.push({
                    x: x,
                    y: y,
                    vx: random(-2, 2),
                    vy: random(-2, 2),
                    life: 50,
                    color: `hsl(${random(0, 360)}, 100%, 50%)`,
                });
            }
        }

        Firework.prototype.update = function () {
            this.sparks.forEach((spark) => {
                spark.x += spark.vx;
                spark.y += spark.vy;
                spark.life -= 1;
            });
            this.sparks = this.sparks.filter((spark) => spark.life > 0);
        };

        Firework.prototype.draw = function () {
            this.sparks.forEach((spark) => {
                ctx.fillStyle = spark.color;
                ctx.fillRect(spark.x, spark.y, 2, 2);
            });
        };

        let fireworks = [];

        function loop() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            fireworks.forEach((firework) => {
                firework.update();
                firework.draw();
            });
            fireworks = fireworks.filter((firework) => firework.sparks.length > 0);
            requestAnimationFrame(loop);
        }

        canvas.addEventListener("click", function (event) {
            fireworks.push(new Firework(event.clientX, event.clientY));

            const popup = document.getElementById("popup");
            popup.style.left = `${event.clientX}px`;
            popup.style.top = `${event.clientY}px`;
            popup.style.display = "block";
            setTimeout(() => {
                popup.style.display = "none";
            }, 1000);
        });

        loop();
    </script>
</body>
</html>

