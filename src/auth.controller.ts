import { Body, Controller, Post } from "@nestjs/common";
import { AuthService } from "./auth.service";
import { AuthDto, LogInDto } from "./dto";


@Controller('auth')

export class AuthController{

    constructor(private authService:AuthService){}
@Post('userSignUp')
signup(@Body() dto:AuthDto){
    return this.authService.userSingUp(dto);
}

@Post('userSignIn')

signIn(@Body() dto:LogInDto){
    return this.authService.userSingIn(dto);
}
}