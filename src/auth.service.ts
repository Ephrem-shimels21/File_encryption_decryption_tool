import { ForbiddenException, Injectable } from "@nestjs/common";
import { AuthDto, LogInDto } from "./dto";
import { JwtService } from "@nestjs/jwt";
import { ConfigService } from "@nestjs/config";
import * as bcrypt from 'bcrypt';
import { PrismaService } from "./prisma/prisma.service";
import { randomBytes } from 'crypto';


@Injectable()
export class AuthService{
    constructor(
        private prisma:PrismaService,
        private jwt: JwtService,
        private config: ConfigService
    ){}

async GenerateToken(
    userId: number,
    email: string,
    enckey: string ):Promise<{access_token : string , enckey: string}>{
    const payload = {
        sub: userId,
        email,
        enckey
    };
const secret = this.config.get('JWT_SECRET');
const token = await this.jwt.signAsync(
    payload,
    {
      expiresIn: '6000m',
      secret: secret,
    },
  );
  return {
    access_token: token, enckey: enckey
  };
}

async  userSingUp(dto: AuthDto){
const saltOrRounds = 10;
const hash = await bcrypt.hash(dto.password, saltOrRounds);
const rankey = randomBytes(16);
const key = rankey.toString('hex');
try{
const user = await this.prisma.Users.create({
    data: {
        user_name: dto.name,
        email : dto.email,
        password: hash,
        key :  key
    }
});
return this.GenerateToken(user.id,user.email,user.key); 
} catch (error) {
    if (error.code == 'P2002'){
        throw new ForbiddenException(
            'Credentials taken, use another one',
        );
    }
}
}

async userSingIn(dto:LogInDto){

    const user = await this.prisma.Users.findUnique({
        where: {
            email: dto.email
        }
    })

    if (!user){
        throw new ForbiddenException("Incorrect Email, There is no user with such email")
    }
    const isMatch = await bcrypt.compare(dto.password, user.password);

    if (!isMatch){
        throw new ForbiddenException("Incorrect password")
    }

    return this.GenerateToken(user.id, user.email,user.key);
  }  
}

