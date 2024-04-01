import { transporter } from '../config/email.js';

const sendMail = async (option) => {
  await transporter.sendMail({
    from: option.from, // sender address
    to: option.to, // list of receivers
    subject: option.subject, // Subject line
    text: option.text, // plain text body
    html: option.html, // html body
  });
};
export default { sendMail };
