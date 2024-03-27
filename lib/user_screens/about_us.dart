import 'package:flutter/material.dart';
import 'package:pronouncepro/user_screens/drawer.dart';
import 'package:pronouncepro/user_screens/home.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 154, 137),
        foregroundColor: Colors.white,
        title: const Text("About Us"),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: const Icon(Icons.home, color: Colors.white)
              ),
              const SizedBox(width: 15)
            ],
          )
        ]
      ),
      drawer: SideNavigation(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text("About Us:", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Divider(thickness: 0.5, color: Colors.grey),
              SizedBox(height: 8),
              Text("Welcome to PronouncePro, where language learning meets innovation! \n\nWe're passionate about breaking down barriers and making language learning accessible, engaging, and effective for everyone, everywhere. At PronouncePro, we understand that learning a new language can be a thrilling journey, but it can also be daunting. \n\nThat's why we've crafted an immersive and dynamic platform that caters to learners of all levels, from beginners to advanced speakers. Whether you're looking to enhance your language skills for travel, work, or personal enrichment, we're here to support you every step of the way. Our team is comprised of language enthusiasts, educators, and technology experts who are dedicated to creating a seamless learning experience. \n\nWe believe in the power of technology to revolutionize education, and we leverage the latest advancements to provide you with innovative tools and resources. With our user-friendly interface and diverse range of features, you'll have the flexibility to learn at your own pace, on your own schedule. \nFrom interactive lessons and exercises to real-world conversations and cultural insights, our platform offers a comprehensive approach to language acquisition. But we're more than just a language learning app—we're a global community united by our shared love for languages. \n\nConnect with fellow learners from around the world, practice your skills with native speakers, and embark on a journey of cultural discovery together. Join us at PronouncePro and unlock the world of possibilities that language learning has to offer. Whether you're mastering a new language for professional growth, personal enrichment, or simply the joy of learning, we're here to empower you on your language learning journey. Start exploring, start connecting, and start speaking with confidence today. \n\nWelcome to PronouncePro!.",
              style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(height: 8),
              Divider(thickness: 0.5, color: Colors.grey),
              SizedBox(height: 8),
              Text("Terms and Conditions", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text("Welcome to PronouncePro! These Terms and Conditions (\"Terms\") govern your use of PronouncePro, including all content, features, and services offered through the PronouncePro mobile application (the \"App\"). By accessing or using PronouncePro, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use PronouncePro.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("\n1. User Accounts", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("1.1. In order to access certain features of PronouncePro, you may be required to create a user account. You agree to provide accurate, current, and complete information during the registration process and to update such information to keep it accurate, current, and complete.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("1.2. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account or any other breach of security.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("\n2. Use of the App", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("2.1. PronouncePro is intended for personal, non-commercial use only. You may not use PronouncePro for any illegal or unauthorized purpose.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("2.2. You agree not to engage in any activity that could interfere with or disrupt the operation of PronouncePro or the servers and networks connected to PronouncePro.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("2.3. You may not access or use PronouncePro in any manner that could damage, disable, overburden, or impair PronouncePro or interfere with any other party's use and enjoyment of PronouncePro.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("\n3. Content", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("3.1. All content available through PronouncePro, including but not limited to text, audio, images, and videos, is provided for informational purposes only. We do not guarantee the accuracy, completeness, or usefulness of any content available through PronouncePro.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("3.2. You may not modify, adapt, translate, reverse engineer, decompile, or disassemble any portion of PronouncePro or its content.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("\n4. Intellectual Property", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("4.1. All intellectual property rights in PronouncePro and its content are owned by PronouncePro or its licensors. You may not use, reproduce, distribute, or display any trademarks, logos, or copyrighted material without the prior written consent of the owner.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("\n5. Privacy", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("5.1. Your privacy is important to us. Please review our Privacy Policy [link to Privacy Policy] to understand how we collect, use, and disclose information about you.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("\n6. Termination", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("6.1. We reserve the right to terminate or suspend your access to PronouncePro at any time, with or without cause, and without prior notice.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("\n7. Changes to Terms", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("7.1. We may revise these Terms from time to time without prior notice. The most current version of these Terms will be posted on PronouncePro. By continuing to use PronouncePro after we post any changes to these Terms, you agree to be bound by the revised Terms.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("\n8. Governing Law", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("8.1. These Terms shall be governed by and construed in accordance with the laws of [Your Jurisdiction], without regard to its conflict of law principles.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("\n9. Contact Us", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("9.1. If you have any questions or concerns about these Terms, please contact us at contactpronouncepro@gmail.com.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(height: 8),
              Divider(thickness: 0.5, color: Colors.grey),
              SizedBox(height: 8),
              Text("Privacy Policy", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text("\n1. Information We Collect", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("1.1. Information You Provide: When you create an account, use certain features, or communicate with us, you may choose to provide us with certain personal information, such as your name, email address, and language preferences.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("1.2. Usage Information: We may automatically collect certain information about your use of PronouncePro, including your device type, operating system, IP address, and usage patterns.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("1.3. Location Information: With your consent, we may collect information about your approximate location based on your IP address or mobile device GPS data.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("\n2. How We Use The Information", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("2.1. We may use the information we collect for various purposes, including to:\n*Provide and improve PronouncePro\n*Customize your experience and content preferences\n*Communicate with you about PronouncePro and respond to your inquiries\n*Analyze usage trends and user demographics\n*Detect, prevent, and address technical issues\n*Comply with legal obligations.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("\n3.Information Sharing and Disclosure", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("3.1. We may share your information with third parties for various purposes, including to:\nService Providers: *We may share your information with third-party service providers who help us operate, maintain, and improve PronouncePro.\nLegal Compliance: We may disclose your information to comply with applicable laws, regulations, legal processes, or governmental requests.\nBusiness Transfers: If PronouncePro is involved in a merger, acquisition, or sale of assets, your information may be transferred as part of that transaction.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("\n4. Data Security", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("4.1. We take reasonable measures to protect the security of your information, but please be aware that no method of transmission over the internet or electronic storage is 100% secure.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("\n5. Your Choices", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("5.1. You may update or delete your account information at any time by accessing your account settings within PronouncePro.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("5.2. You may opt out of receiving promotional communications from us by following the instructions provided in such communications.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("\n6. Children's Privacy", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("6.1. PronouncePro is not intended for children under the age of 13, and we do not knowingly collect personal information from children under 13. If you believe that we may have collected information from a child under 13, please contact us.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("\n7. Changes to this Privacy Policy", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("7.1. We may revise this Privacy Policy from time to time. The most current version of the Privacy Policy will be posted on PronouncePro. By continuing to use PronouncePro after we make any changes to this Privacy Policy, you agree to be bound by the revised Privacy Policy.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              Text("\n8. Contact Us", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("8.1. If you have any questions or concerns about this Privacy Policy, please contact us at contactpronouncepro@gmail.com.", style: TextStyle(fontSize: 16, color: Colors.grey)),
              SizedBox(height: 8),
              Divider(thickness: 0.5, color: Colors.grey),
              SizedBox(height: 8),
              Center(child: Text("Version 1.0", style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold)),)
            ],
          ),
        ),
      )
    );
  }
}