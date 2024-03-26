import { transporter } from '../config/email.js';

const sendMail = async (option) => {
  const info = await transporter.sendMail({
    from: option.from, // sender address
    to: option.to, // list of receivers
    subject: option.subject, // Subject line
    text: option.text, // plain text body
    html: option.html, // html body
  });
  console.log('Message sent: %s', info);
};
export default { sendMail };
