<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up and Login Form</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Playfair+Display">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/loginSignup.css">
    <style>
        /* CSS for animation */
        @keyframes textChange {
            0% {
                transform: scale(1);
                opacity: 1;
            }
            50% {
                transform: scale(1.1);
                opacity: 1;
            }
            100% {
                transform: scale(1);
                opacity: 0;
            }
        }
    </style>
</head>
<body>
<br>
<br>
<br>
<br>
<br>
<br>

<div class="cont">
    <div class="form sign-in">
        <h2>Welcome</h2>
        <form method="post" action="login">
            <label>
                <span>Email</span>
                <input type="email" name="email"/>
            </label>
            <label>
                <span>Password</span>
                <input type="password" name="password"/>
            </label>
            <p class="forgot-pass">Forgot password?</p>
            <button type="submit" class="submit">Sign In</button>
        </form>

    </div>

    <div class="sub-cont">
        <div class="img">
            <div class="img__text m--up">
                <h3>Don't have an account? Please Sign up!</h3>
            </div>
            <div class="img__text m--in">
                <h3>If you already have an account, just sign in.</h3>
            </div>
            <div class="img__btn">
                <span class="m--up">Sign Up</span>
                <span class="m--in">Sign In</span>
            </div>
        </div>
        <div class="form sign-up">
            <h2>Create your Account</h2>
            <form method="post" action="signup">
                <label>
                    <span>Name</span>
                    <input type="text" name="fullName"/>
                </label>
                <label>
                    <span>Email</span>
                    <input type="email" name="email"/>
                </label>
                <label>
                    <span>Password</span>
                    <input type="password" name="password"/>
                </label>
                <label>
                    <span>Phone Number</span>
                    <input type="text" name="number"/>
                </label>
                <button type="submit" class="submit">Sign Up</button>
            </form>
        </div>
    </div>
</div>

<script>
    document.querySelector('.img__btn').addEventListener('click', function () {
        document.querySelector('.cont').classList.toggle('s--signup');
    });

    document.getElementById('signupButton').addEventListener('click', function (event) {
        event.preventDefault();

        this.innerText = 'Successfully';


        this.classList.add('success-animation');

        setTimeout(() => {
            this.innerText = 'Sign Up';
            this.classList.remove('success-animation');
        }, 2000);
    });
</script>
</body>
</html>
