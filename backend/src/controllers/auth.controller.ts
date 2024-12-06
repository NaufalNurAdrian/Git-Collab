import { Request, Response } from "express";
import { findUser } from "../services/auth.sevices";
import { compare, genSalt, hash } from "bcrypt";
import prisma from "../prisma";
import { sign, verify } from "jsonwebtoken";

export class AuthController {
  // async registerUser(req: Request, res: Response) {
  //   try {
  //     const { password, confirmPassword, username, email, referal } = req.body;

  //     // Validasi password
  //     if (!password || password !== confirmPassword) {
  //       return res.status(400).json({ message: "Passwords do not match!" });
  //     }

  //     // Periksa username/email sudah digunakan
  //     const userExists = await findUser(username, email);
  //     if (userExists) {
  //       return res.status(400).json({ message: "Username or email already exists!" });
  //     }

  //     const salt = await genSalt(10);
  //     const hashedPassword = await hash(password, salt);

  //     let referalOwnerId: number | null = null;

  //     if (referal) {
  //       const referalOwner = await prisma.user.findFirst({
  //         where: { referralCode: referal },
  //         include: { ReferralLog: true },
  //       });

  //       if (!referalOwner) {
  //         return res.status(400).json({ message: "Invalid referral code!" });
  //       }

  //       referalOwnerId = referalOwner.user_id;

  //       await prisma.referralLog.create({
  //         data: {
  //           user_id: referalOwnerId,
  //           pointsAwarded: 10000,
  //           used: true,
  //         },
  //       });
  //     }

  //     const newUser = await prisma.user.create({
  //       data: {
  //         username,
  //         email,
  //         password: hashedPassword,
  //         referralCode: `${username}-${Date.now()}`,
  //         points: 0, 
  //         role: "CUSTOMER", 
  //       },
  //     });

  //     return res.status(201).json({
  //       status: "success",
  //       message: "Register successfully!",
  //       data: {
  //         id: newUser.user_id,
  //         username: newUser.username,
  //         email: newUser.email,
  //         referralCode: newUser.referralCode,
  //       },
  //     });
  //   } catch (error) {
  //     console.error(error);
  //     return res.status(500).json({ status: "error", message: "Internal server error!" });
  //   }
  // }

  
    async loginUser(req: Request, res: Response) {
      try {
        const { data, password } = req.body;
        const user = await findUser(data, data);
  
        if (!user) throw { message: "Account not found !" };
        if (user.isSuspend) throw { message: "Account Suspended !" };
        if (!user.isVerify) throw { message: "Account Not Verify !" };
  
        const isValidPass = await compare(password, user.password);
        if (!isValidPass) {
          await prisma.user.update({
            data: { loginAttempt: { increment: 1 } },
            where: { user_id: user.user_id },
          });
          if (user.loginAttempt == 2) {
            await prisma.user.update({
              data: { isSuspend: true },
              where: { user_id: user.user_id },
            });
          }
          throw { message: "Incorrect Password !" };
        }
  
        await prisma.user.update({
          data: { loginAttempt: 0 },
          where: { user_id: user.user_id },
        });
  
        const payload = { id: user.user_id, role: user.role };
        const token = sign(payload, process.env.JWT_KEY!, { expiresIn: "1d" });
  
        res
          .status(200)
          .cookie("token", token, {
            httpOnly: true,
            maxAge: 24 * 3600 * 1000,
            path: "/",
            secure: process.env.NODE_ENV === "production",
          })
          .send({
            message: "Login Sucessfully ✅",
            user,
          });
      } catch (err) {
        console.log(err);
        res.status(400).send(err);
      }
    }
  }

