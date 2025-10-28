<?php
// Chat widget configuration
$whatsapp_number = "254718883983"; 

// Load custom responses from database if available
function getCustomResponses() {
    global $con;
    $responses = [];
    if (isset($con)) {
        $query = "SELECT category, keywords, response_text FROM chat_responses WHERE active = 1";
        $result = mysqli_query($con, $query);
        if ($result) {
            while ($row = mysqli_fetch_assoc($result)) {
                $responses[$row['category']] = [
                    'keywords' => explode(',', $row['keywords']),
                    'response' => $row['response_text']
                ];
            }
        }
    }
    return $responses;
}

// Get custom responses
$customResponses = getCustomResponses();
?>

<!-- WhatsApp Chat Widget Styles -->
<style>
.whatsapp-widget {
    position: fixed;
    bottom: 20px;
    left: 20px;
    z-index: 999999;
}

.whatsapp-btn {
    background-color: #25D366;
    color: white;
    border-radius: 50%;
    width: 60px;
    height: 60px;
    display: flex !important;
    align-items: center;
    justify-content: center;
    box-shadow: 0 4px 10px rgba(0,0,0,0.3);
    transition: transform 0.3s ease;
    cursor: pointer;
    font-size: 35px;
}

.whatsapp-btn:hover {
    transform: scale(1.1);
}

.chat-modal {
    position: fixed;
    bottom: 90px;
    left: 20px;
    width: 300px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    display: none;
    overflow: hidden;
    z-index: 999998;
}

.chat-header {
    background: #075E54;
    color: white;
    padding: 15px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.chat-header .title {
    display: flex;
    align-items: center;
}

.chat-header img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 10px;
}

.chat-header .close-chat {
    cursor: pointer;
    font-size: 20px;
    color: white;
}

.chat-body {
    height: 300px;
    overflow-y: auto;
    padding: 15px;
    background: #E5DDD5;
}

.chat-message {
    margin: 10px 0;
    padding: 8px 12px;
    border-radius: 15px;
    max-width: 80%;
    word-wrap: break-word;
}

.received {
    background-color: white;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
}

.sent {
    background-color: #DCF8C6;
    margin-left: auto;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
}

.chat-input {
    padding: 15px;
    border-top: 1px solid #eee;
    display: flex;
    background: white;
}

.chat-input input {
    flex: 1;
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 20px;
    margin-right: 10px;
    outline: none;
}

.chat-input button {
    background: #25D366;
    color: white;
    border: none;
    border-radius: 50%;
    width: 40px;
    height: 40px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background-color 0.3s ease;
}

.chat-input button:hover {
    background: #128C7E;
}

/* Typing indicator animation */
.typing {
    background-color: #f0f0f0 !important;
    padding: 15px !important;
}

.typing span {
    display: inline-block;
    width: 8px;
    height: 8px;
    background-color: #90949c;
    border-radius: 50%;
    margin-right: 5px;
    animation: typing 1s infinite;
}

.typing span:nth-child(2) { animation-delay: 0.2s; }
.typing span:nth-child(3) { animation-delay: 0.4s; }

@keyframes typing {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-5px); }
}

/* Add styles for quick reply buttons */
.quick-replies {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    margin: 10px 0;
}

.quick-reply-btn {
    background-color: #E1F5FE;
    color: #075E54;
    border: 1px solid #B3E5FC;
    border-radius: 15px;
    padding: 8px 15px;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.3s ease;
    max-width: 100%;
    text-align: center;
}

.quick-reply-btn:hover {
    background-color: #B3E5FC;
}
</style>

<!-- WhatsApp Chat Widget HTML -->
<div class="whatsapp-widget">
    <div class="whatsapp-btn" id="whatsappBtn">
        <i class="fab fa-whatsapp"></i>
    </div>
    
    <div class="chat-modal" id="chatModal">
        <div class="chat-header">
            <div class="title">
                <img src="assets/img/Timestenfavicon.png" alt="TimesTen">
                <div>
                    <div style="font-weight: bold;">TimesTen Technologies</div>
                    <div style="font-size: 12px;">AI Assistant</div>
                </div>
            </div>
            <div class="close-chat" id="closeChat">
                <i class="fas fa-times"></i>
            </div>
        </div>
        <div class="chat-body" id="chatBody">
            <!-- Messages will be added here -->
        </div>
        <div class="chat-input">
            <input type="text" id="messageInput" placeholder="Type a message...">
            <button id="sendMessage">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
    </div>
</div>

<!-- WhatsApp Chat Widget Script -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Get DOM elements
    const whatsappBtn = document.getElementById('whatsappBtn');
    const chatModal = document.getElementById('chatModal');
    const closeChat = document.getElementById('closeChat');
    const chatBody = document.getElementById('chatBody');
    const messageInput = document.getElementById('messageInput');
    const sendMessage = document.getElementById('sendMessage');

    // Chat configuration with enhanced AI responses
    const config = {
        welcomeMessage: "👋 Hello! I'm your AI assistant at TimesTen Technologies. How can I help you today?\n\nPlease select what you'd like to know:",
        categories: {
            pricing: {
                keywords: ['price', 'cost', 'quote', 'package', 'budget', 'expensive', 'cheap', 'pricing', 'charges', 'fee'],
                responses: {
                    website: "For websites, our pricing is structured as follows:\n\n" +
                            "• Basic Business Website: KSH 35,000 - 50,000\n" +
                            "• Professional Website: KSH 60,000 - 100,000\n" +
                            "• E-commerce Website: Starting from KSH 150,000\n\n" +
                            "Would you like me to break down what's included in each package?",
                    mobile: "Mobile app development investment ranges:\n\n" +
                            "• Android App: From KSH 200,000\n" +
                            "• iOS App: From KSH 250,000\n" +
                            "• Cross-platform App: From KSH 300,000\n\n" +
                            "What kind of app features are you looking for?",
                    marketing: "Our digital marketing packages are structured as:\n\n" +
                            "• Starter Package: KSH 30,000/month\n" +
                            "• Growth Package: KSH 50,000/month\n" +
                            "• Premium Package: KSH 100,000/month\n\n" +
                            "Would you like to know what's included in each package?",
                    general: "I understand you're interested in pricing. Our services are customized to meet your specific needs. Which service interests you?\n\n" +
                            "• Website Development\n" +
                            "• Mobile App Development\n" +
                            "• Digital Marketing\n\n" +
                            "This will help me provide you with accurate pricing information."
                }
            },
            website: {
                keywords: ['website', 'web', 'site', 'webpage', 'landing page', 'ecommerce', 'cms', 'wordpress'],
                questions: {
                    'cost': ['how much', 'pricing', 'cost', 'package', 'price'],
                    'time': ['how long', 'timeline', 'duration', 'when', 'finish'],
                    'process': ['how do you', 'process', 'steps', 'procedure', 'work'],
                    'features': ['can you', 'feature', 'functionality', 'include', 'support'],
                    'technology': ['tech', 'framework', 'platform', 'language', 'stack']
                },
                responses: {
                    default: "I'd be happy to help you with your website needs. Could you tell me more about the type of website you're looking to create?",
                    cost: "Website costs vary based on requirements. Basic websites start from $500, while e-commerce sites start from $1,500. What features are you looking for?",
                    time: "A basic website typically takes 2-4 weeks, while complex sites may take 2-3 months. When would you like to launch your website?",
                    process: "Our website development process includes: 1) Requirements gathering 2) Design mockups 3) Development 4) Testing 5) Launch. Would you like me to explain any specific phase?",
                    features: "We can include various features like contact forms, booking systems, payment integration, and custom functionality. What specific features interest you?",
                    technology: "We use modern technologies like React, Node.js, WordPress, and Laravel. Do you have a preferred technology stack?"
                }
            },
            mobile: {
                keywords: ['app', 'android', 'ios', 'mobile', 'phone', 'application'],
                questions: {
                    'platform': ['android', 'ios', 'iphone', 'play store', 'app store'],
                    'features': ['can it', 'feature', 'functionality', 'capable', 'support'],
                    'cost': ['how much', 'pricing', 'cost', 'price'],
                    'time': ['how long', 'timeline', 'duration', 'when']
                },
                responses: {
                    default: "We develop both Android and iOS apps. Which platform are you targeting?",
                    platform: "We can develop for both Android and iOS, or create a cross-platform app that works on both. What's your target audience?",
                    features: "Our apps can include features like user authentication, push notifications, offline mode, and API integration. What features do you need?",
                    cost: "Mobile app development starts from $5,000, depending on complexity. Would you like a detailed quote based on your requirements?",
                    time: "App development typically takes 3-6 months. This includes design, development, testing, and store submission. When would you like to start?"
                }
            },
            marketing: {
                keywords: ['marketing', 'seo', 'social', 'ads', 'traffic', 'ranking'],
                questions: {
                    'seo': ['rank', 'google', 'search', 'organic'],
                    'social': ['facebook', 'instagram', 'twitter', 'linkedin'],
                    'ads': ['advertising', 'ppc', 'campaign'],
                    'cost': ['how much', 'pricing', 'cost', 'price'],
                    'results': ['how long', 'when', 'results', 'expect']
                },
                responses: {
                    default: "We offer comprehensive digital marketing services. Which area interests you most: SEO, Social Media, or Paid Advertising?",
                    seo: "Our SEO services improve your Google rankings through technical optimization, content strategy, and link building. Would you like to know our SEO process?",
                    social: "We manage social media presence across all major platforms, creating engaging content and growing your audience. Which platforms are you targeting?",
                    ads: "Our ad campaigns are optimized for maximum ROI, whether on Google, Facebook, or other platforms. What's your advertising budget?",
                    cost: "Marketing packages start from $500/month. Would you like to see our detailed pricing plans?",
                    results: "Initial results are usually visible within 2-3 months, with significant improvements by 6 months. Shall I explain our reporting process?"
                }
            }
        },
        fallbackResponses: [
            "I understand you're interested in our services. Could you please provide more details about your specific needs?",
            "That's an interesting question! To help you better, could you specify which of our services you're interested in?",
            "I'd be happy to help! Could you tell me more about your project requirements?",
            "Let me make sure I understand your needs correctly. Are you looking for information about our web development, mobile apps, or digital marketing services?"
        ]
    };

    // Quick reply options
    const quickReplies = {
        main: [
            { text: "How much does a website cost?", value: "website_cost" },
            { text: "I need a mobile app", value: "mobile_inquiry" },
            { text: "Help me with digital marketing", value: "marketing_help" },
            { text: "Show me your portfolio", value: "portfolio" },
            { text: "Book a consultation", value: "consultation" }
        ],
        website: [
            { text: "Business Website Package", value: "business_website" },
            { text: "E-commerce Store", value: "ecommerce" },
            { text: "Custom Web System", value: "custom_web" },
            { text: "Website Maintenance", value: "maintenance" }
        ],
        mobile: [
            { text: "Android App Development", value: "android" },
            { text: "iOS App Development", value: "ios" },
            { text: "Both Android & iOS", value: "cross_platform" },
            { text: "App Cost Calculator", value: "app_cost" }
        ],
        marketing: [
            { text: "Grow my business online", value: "digital_growth" },
            { text: "Increase website traffic", value: "seo" },
            { text: "Social Media Management", value: "social" },
            { text: "Google Ads Campaign", value: "google_ads" }
        ],
        timeline: [
            { text: "Start Immediately", value: "immediate" },
            { text: "Within 1 Month", value: "one_month" },
            { text: "In 2-3 Months", value: "three_months" },
            { text: "Just Researching", value: "research" }
        ]
    };

    // Toggle chat modal
    whatsappBtn.addEventListener('click', function() {
        chatModal.style.display = chatModal.style.display === 'none' ? 'block' : 'none';
        if (chatBody.children.length === 0) {
            addMessage(config.welcomeMessage, 'received');
            setTimeout(() => {
                addQuickReplies('main');
            }, 500);
        }
    });

    // Close chat
    closeChat.addEventListener('click', function() {
        chatModal.style.display = 'none';
    });

    // Send message
    function sendMessageHandler() {
        const message = messageInput.value.trim();
        if (message) {
            addMessage(message, 'sent');
            messageInput.value = '';
            generateResponse(message.toLowerCase());
        }
    }

    // Handle send button click
    sendMessage.addEventListener('click', sendMessageHandler);

    // Handle enter key
    messageInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            sendMessageHandler();
        }
    });

    // Add message to chat
    function addMessage(text, type) {
        const message = document.createElement('div');
        message.className = `chat-message ${type}`;
        message.textContent = text;
        chatBody.appendChild(message);
        chatBody.scrollTop = chatBody.scrollHeight;
    }

    // Optimize typing indicator timing based on message length
    function getTypingDelay(message) {
        const words = message.split(' ').length;
        const baseDelay = 500; // Base delay in milliseconds
        const wordDelay = 100; // Delay per word
        return Math.min(baseDelay + (words * wordDelay), 2000); // Cap at 2 seconds
    }

    // Enhanced response generation with optimized timing
    function generateResponse(userMessage) {
        const message = userMessage.toLowerCase();
        let response = null;
        let category = null;
        let questionType = null;

        // Add typing indicator immediately
        addTypingIndicator();

        // Check for pricing queries first
        if (config.categories.pricing.keywords.some(keyword => message.includes(keyword))) {
            category = 'pricing';
            
            // Determine specific pricing category
            for (const [type, keywords] of Object.entries(config.categories.pricing.questions)) {
                if (keywords.some(keyword => message.includes(keyword))) {
                    questionType = type;
                    break;
                }
            }

            // Get appropriate pricing response
            response = config.categories.pricing.responses[questionType || 'general'];
            
            // Calculate typing delay based on response length
            const typingDelay = getTypingDelay(response);
            
            setTimeout(() => {
                removeTypingIndicator();
                addMessage(response, 'received');
                
                // Add relevant follow-up questions based on pricing type
                setTimeout(() => {
                    const followUpQuestions = getFollowUpQuestions(questionType);
                    addSequentialQuestions(followUpQuestions);
                }, Math.min(typingDelay, 1000));
            }, typingDelay);
            return;
        }

        // Identify category
        for (const [cat, data] of Object.entries(config.categories)) {
            if (data.keywords.some(keyword => message.includes(keyword))) {
                category = cat;
                break;
            }
        }

        if (category) {
            const categoryData = config.categories[category];
            
            // Identify question type
            for (const [qType, patterns] of Object.entries(categoryData.questions)) {
                if (patterns.some(pattern => message.includes(pattern))) {
                    questionType = qType;
                    break;
                }
            }

            // Get appropriate response
            if (questionType && categoryData.responses[questionType]) {
                response = categoryData.responses[questionType];
            } else {
                response = categoryData.responses.default;
            }

            // Calculate typing delay based on response length
            const typingDelay = getTypingDelay(response);
            
            setTimeout(() => {
                removeTypingIndicator();
                addMessage(response, 'received');
                
                // Add follow-up questions based on category
                setTimeout(() => {
                    let followUpQuestions = [];
                    if (category === 'website') {
                        followUpQuestions = [
                            "What specific features would you like in your website?",
                            "Do you have a design preference or existing brand guidelines?",
                            "When would you like to launch your website?"
                        ];
                    } else if (category === 'mobile') {
                        followUpQuestions = [
                            "Which platform are you targeting - Android, iOS, or both?",
                            "What are the key features you need in your app?",
                            "Do you have a specific timeline in mind?"
                        ];
                    } else if (category === 'marketing') {
                        followUpQuestions = [
                            "What are your main marketing goals?",
                            "Which platforms would you like to focus on?",
                            "Do you have a specific budget in mind?"
                        ];
                    }

                    // Add follow-up questions with optimized timing
                    addSequentialQuestions(followUpQuestions);
                }, Math.min(typingDelay, 1000));
            }, typingDelay);
        } else {
            // Use fallback responses with more context
            const generalResponses = [
                "I'd be happy to help you! Could you tell me more about what type of service you're interested in? We offer:",
                "• Web Development (websites, e-commerce, CMS)",
                "• Mobile App Development (Android & iOS)",
                "• Digital Marketing (SEO, Social Media, Ads)",
                "• IT Consulting and Support",
                "Which of these services would you like to learn more about?"
            ];
            
            // Add initial response with typing effect
            addTypingIndicator();
            setTimeout(() => {
                removeTypingIndicator();
                // Add each line of the response with a small delay
                generalResponses.forEach((line, index) => {
                    setTimeout(() => {
                        addMessage(line, 'received');
                    }, index * 500);
                });
                
                // Add follow-up questions after the general response
                setTimeout(() => {
                    const generalQuestions = [
                        "What type of project are you planning?",
                        "Do you have any specific requirements or goals?",
                        "Would you like to see some examples of our previous work?"
                    ];

                    generalQuestions.forEach((question, index) => {
                        setTimeout(() => {
                            addTypingIndicator();
                            setTimeout(() => {
                                removeTypingIndicator();
                                addMessage(question, 'received');
                                
                                // Add WhatsApp suggestion after last question
                                if (index === generalQuestions.length - 1) {
                                    setTimeout(() => {
                                        addTypingIndicator();
                                        setTimeout(() => {
                                            removeTypingIndicator();
                                            addMessage("Would you like to discuss this further with our team? We can provide more detailed information and custom solutions on WhatsApp.", 'received');
                                            addWhatsAppButton(question);
                                        }, 1000);
                                    }, 2000);
                                }
                            }, 1000);
                        }, (index + 1) * 3000);
                    });
                }, generalResponses.length * 500 + 1000);
            }, 1500);
        }
    }

    // Helper function to get follow-up questions
    function getFollowUpQuestions(type) {
        const questions = {
            website: [
                "What type of website functionality do you need?",
                "Do you have existing brand guidelines or design preferences?",
                "What's your target timeline for launching the website?"
            ],
            mobile: [
                "Which platform would you prefer - Android, iOS, or both?",
                "What are the main features your app needs to have?",
                "Do you have a specific launch date in mind?"
            ],
            marketing: [
                "What are your primary marketing objectives?",
                "Which digital channels are most important for your business?",
                "What's your monthly marketing budget?"
            ],
            ecommerce: [
                "How many products do you plan to sell?",
                "Do you need multi-currency support?",
                "Would you like to integrate with specific payment gateways?"
            ],
            maintenance: [
                "How often do you update your website content?",
                "Do you need regular security audits?",
                "What level of technical support do you require?"
            ],
            default: [
                "Could you tell me more about your project requirements?",
                "What's your budget range for this project?",
                "When would you like to get started?"
            ]
        };
        return questions[type] || questions.default;
    }

    // Function to add questions sequentially with optimized timing
    function addSequentialQuestions(questions) {
        questions.forEach((question, index) => {
            setTimeout(() => {
                addTypingIndicator();
                const typingDelay = getTypingDelay(question);
                
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage(question, 'received');
                    
                    // Add WhatsApp suggestion after last question
                    if (index === questions.length - 1) {
                        setTimeout(() => {
                            addTypingIndicator();
                            setTimeout(() => {
                                removeTypingIndicator();
                                addMessage("Would you like to discuss your requirements in detail with our team on WhatsApp?", 'received');
                                addWhatsAppButton(question);
                            }, 800);
                        }, 1500);
                    }
                }, typingDelay);
            }, index * (typingDelay + 1000));
        });
    }

    // Add typing indicator
    function addTypingIndicator() {
        const typing = document.createElement('div');
        typing.id = 'typing-indicator';
        typing.className = 'chat-message received typing';
        typing.innerHTML = '<span></span><span></span><span></span>';
        chatBody.appendChild(typing);
        chatBody.scrollTop = chatBody.scrollHeight;
    }

    // Remove typing indicator
    function removeTypingIndicator() {
        const typing = document.getElementById('typing-indicator');
        if (typing) typing.remove();
    }

    // Add WhatsApp button
    function addWhatsAppButton(message) {
        const whatsappLink = document.createElement('div');
        whatsappLink.className = 'chat-message received';
        whatsappLink.innerHTML = `
            <a href="https://wa.me/<?php echo $whatsapp_number; ?>?text=${encodeURIComponent(message)}" 
               target="_blank" 
               style="display: inline-block; background: #25D366; color: white; padding: 8px 15px; border-radius: 20px; text-decoration: none; margin-top: 5px;">
                <i class="fab fa-whatsapp"></i> Continue on WhatsApp
            </a>
        `;
        chatBody.appendChild(whatsappLink);
        chatBody.scrollTop = chatBody.scrollHeight;
    }

    // Function to add quick reply buttons
    function addQuickReplies(category) {
        const quickReplyDiv = document.createElement('div');
        quickReplyDiv.className = 'chat-message received quick-replies';
        
        const buttons = quickReplies[category] || quickReplies.main;
        buttons.forEach(button => {
            const btn = document.createElement('button');
            btn.className = 'quick-reply-btn';
            btn.textContent = button.text;
            btn.onclick = () => handleQuickReply(button.value, button.text);
            quickReplyDiv.appendChild(btn);
        });
        
        chatBody.appendChild(quickReplyDiv);
        chatBody.scrollTop = chatBody.scrollHeight;
    }

    // Function to handle quick reply clicks
    function handleQuickReply(value, text) {
        addMessage(text, 'sent');

        switch(value) {
            case 'website_cost':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("I'll help you understand our website pricing packages that are tailored for Kenyan businesses:", 'received');
                    setTimeout(() => {
                        addMessage("🌟 Our Website Packages:\n\n" +
                            "1. Basic Business Website: KSH 35,000 - 50,000\n" +
                            "   ✓ 5 Professional Pages\n" +
                            "   ✓ Mobile Responsive Design\n" +
                            "   ✓ Contact Forms\n" +
                            "   ✓ Social Media Integration\n" +
                            "   ✓ Free Domain & Hosting (1 year)\n\n" +
                            "2. Professional Website: KSH 60,000 - 100,000\n" +
                            "   ✓ Up to 10 Custom Pages\n" +
                            "   ✓ Content Management System\n" +
                            "   ✓ Advanced Features\n" +
                            "   ✓ SEO Optimization\n" +
                            "   ✓ Business Email Setup\n\n" +
                            "3. E-commerce Website: From KSH 150,000\n" +
                            "   ✓ Full Online Store\n" +
                            "   ✓ M-PESA Integration\n" +
                            "   ✓ Product Management\n" +
                            "   ✓ Order System\n" +
                            "   ✓ Inventory Management", 'received');
                        setTimeout(() => {
                            addMessage("Which package interests you? I can explain more about any specific package.", 'received');
                            addQuickReplies('website');
                        }, 1500);
                    }, 1000);
                }, 1000);
                break;

            case 'business_website':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("Excellent choice! Let me tell you more about our Business Website Package:", 'received');
                    setTimeout(() => {
                        addMessage("💼 Business Website Package Details:\n\n" +
                            "Investment: KSH 35,000 - 50,000\n\n" +
                            "What's Included:\n" +
                            "✓ Professional Web Design\n" +
                            "✓ 5 Custom Pages (Home, About, Services, Gallery, Contact)\n" +
                            "✓ Mobile-Friendly Design\n" +
                            "✓ Contact & Inquiry Forms\n" +
                            "✓ Social Media Integration\n" +
                            "✓ Google Maps Integration\n" +
                            "✓ Basic SEO Setup\n" +
                            "✓ Google Analytics\n" +
                            "✓ 1 Year Free Hosting\n" +
                            "✓ Free Domain Name\n" +
                            "✓ SSL Certificate\n" +
                            "✓ 3 Months Free Support", 'received');
                        setTimeout(() => {
                            addMessage("When would you like to start your project? Choose an option:", 'received');
                            addQuickReplies('timeline');
                        }, 1500);
                    }, 1000);
                }, 1000);
                break;

            case 'ecommerce':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("Let me explain our E-commerce Website Package in detail:", 'received');
                    setTimeout(() => {
                        addMessage("🛍️ E-commerce Website Package Details:\n\n" +
                            "Investment: Starting from KSH 150,000\n\n" +
                            "Complete E-commerce Solution:\n" +
                            "✓ Professional Store Design\n" +
                            "✓ Unlimited Products & Categories\n" +
                            "✓ M-PESA Integration\n" +
                            "✓ Card Payment Integration (Optional)\n" +
                            "✓ Order Management System\n" +
                            "✓ Inventory Tracking\n" +
                            "✓ Customer Accounts\n" +
                            "✓ Mobile Shopping App\n" +
                            "✓ Product Search & Filters\n" +
                            "✓ Multiple Currency Support\n" +
                            "✓ Delivery Integration\n" +
                            "✓ Sales Analytics\n" +
                            "✓ Marketing Tools Integration\n" +
                            "✓ 6 Months Free Support\n" +
                            "✓ Staff Training\n\n" +
                            "Optional Add-ons:\n" +
                            "• Multi-vendor Marketplace: +KSH 100,000\n" +
                            "• Custom Mobile App: +KSH 200,000\n" +
                            "• Advanced Analytics: +KSH 50,000", 'received');
                        setTimeout(() => {
                            addMessage("When would you like to launch your online store?", 'received');
                            addQuickReplies('timeline');
                        }, 1500);
                    }, 1000);
                }, 1000);
                break;

            case 'custom_web':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("For custom web systems, we provide tailored solutions based on your specific needs:", 'received');
                    setTimeout(() => {
                        addMessage("🔧 Custom Web Solutions:\n\n" +
                            "• School Management Systems\n" +
                            "• HR & Payroll Systems\n" +
                            "• Booking & Reservation Systems\n" +
                            "• Custom CRM Solutions\n" +
                            "• Inventory Management Systems\n" +
                            "• Real Estate Portals\n" +
                            "• Healthcare Management Systems\n\n" +
                            "Pricing is based on your specific requirements.", 'received');
                        setTimeout(() => {
                            addMessage("What type of system are you looking to build? Let's discuss your requirements.", 'received');
                            const customOptions = [
                                { text: "School System", value: "school_system" },
                                { text: "HR System", value: "hr_system" },
                                { text: "Booking System", value: "booking_system" },
                                { text: "Other Custom System", value: "other_system" }
                            ];
                            addCustomQuickReplies(customOptions);
                        }, 1500);
                    }, 1000);
                }, 1000);
                break;

            case 'maintenance':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("Here are our Website Maintenance Plans:", 'received');
                    setTimeout(() => {
                        addMessage("🛠️ Maintenance Package Options:\n\n" +
                            "1. Basic Care: KSH 5,000/month\n" +
                            "   ✓ Weekly Backups\n" +
                            "   ✓ Security Updates\n" +
                            "   ✓ Uptime Monitoring\n" +
                            "   ✓ Basic SEO Maintenance\n" +
                            "   ✓ 5 Content Updates\n\n" +
                            "2. Business Care: KSH 10,000/month\n" +
                            "   ✓ Daily Backups\n" +
                            "   ✓ Security Updates & Monitoring\n" +
                            "   ✓ Performance Optimization\n" +
                            "   ✓ 10 Content Updates\n" +
                            "   ✓ Monthly Analytics Report\n" +
                            "   ✓ Technical Support\n\n" +
                            "3. Premium Care: KSH 20,000/month\n" +
                            "   ✓ Real-time Backups\n" +
                            "   ✓ Advanced Security Suite\n" +
                            "   ✓ Unlimited Updates\n" +
                            "   ✓ SEO Optimization\n" +
                            "   ✓ Priority Support 24/7\n" +
                            "   ✓ Monthly Strategy Meeting", 'received');
                        setTimeout(() => {
                            addMessage("Which maintenance plan would best suit your needs?", 'received');
                            const maintenanceReplies = [
                                { text: "Basic Care Plan", value: "basic_maintenance" },
                                { text: "Business Care Plan", value: "business_maintenance" },
                                { text: "Premium Care Plan", value: "premium_maintenance" },
                                { text: "Custom Plan", value: "custom_maintenance" }
                            ];
                            addCustomQuickReplies(maintenanceReplies);
                        }, 1500);
                    }, 1000);
                }, 1000);
                break;

            // Add handlers for timeline options
            case 'immediate':
            case 'one_month':
            case 'three_months':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("Perfect! Let's get your project started. To proceed, we'll need to:", 'received');
                    setTimeout(() => {
                        addMessage("1. Schedule a detailed requirements discussion\n" +
                            "2. Prepare a custom quote\n" +
                            "3. Create a project timeline\n" +
                            "4. Begin the design phase\n\n" +
                            "Would you like to schedule a meeting with our team?", 'received');
                        const nextStepOptions = [
                            { text: "Schedule Meeting", value: "schedule_meeting" },
                            { text: "Get Quote First", value: "request_quote" },
                            { text: "Talk on WhatsApp", value: "whatsapp_chat" }
                        ];
                        addCustomQuickReplies(nextStepOptions);
                    }, 1000);
                }, 1000);
                break;

            case 'research':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("I understand you're researching options. Let me help you gather the information you need:", 'received');
                    setTimeout(() => {
                        addMessage("What would you like to know more about?\n\n" +
                            "• View our portfolio\n" +
                            "• Compare packages\n" +
                            "• Read case studies\n" +
                            "• Development process", 'received');
                        const researchOptions = [
                            { text: "View Portfolio", value: "view_portfolio" },
                            { text: "Compare Packages", value: "compare_packages" },
                            { text: "Case Studies", value: "case_studies" },
                            { text: "Development Process", value: "dev_process" }
                        ];
                        addCustomQuickReplies(researchOptions);
                    }, 1000);
                }, 1000);
                break;

            case 'request_quote':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("I'll help you get a detailed quote for your project. To provide an accurate estimate, please tell me:", 'received');
                    setTimeout(() => {
                        addMessage("📋 Quick Project Brief:\n\n" +
                            "1. Type of Project:\n" +
                            "   • Website Development\n" +
                            "   • Mobile App Development\n" +
                            "   • Digital Marketing\n" +
                            "   • Custom Solution\n\n" +
                            "2. Your Budget Range:\n" +
                            "   • KSH 35,000 - 50,000\n" +
                            "   • KSH 60,000 - 100,000\n" +
                            "   • KSH 100,000+\n\n" +
                            "3. Timeline:\n" +
                            "   • Urgent (1-2 weeks)\n" +
                            "   • Standard (3-4 weeks)\n" +
                            "   • Flexible\n\n" +
                            "Select your project type to begin:", 'received');
                        const quoteOptions = [
                            { text: "Website Quote", value: "quote_website" },
                            { text: "Mobile App Quote", value: "quote_app" },
                            { text: "Marketing Quote", value: "quote_marketing" },
                            { text: "Custom Quote", value: "quote_custom" }
                        ];
                        addCustomQuickReplies(quoteOptions);
                    }, 1000);
                }, 1000);
                break;

            case 'whatsapp_chat':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("Great choice! Our team is ready to assist you on WhatsApp. You'll be able to:", 'received');
                    setTimeout(() => {
                        addMessage("📱 On WhatsApp, we can:\n\n" +
                            "• Share project details & requirements\n" +
                            "• Send example designs & portfolios\n" +
                            "• Discuss pricing & timelines\n" +
                            "• Schedule video calls\n" +
                            "• Share documents & resources\n\n" +
                            "Click the button below to continue the conversation on WhatsApp:", 'received');
                        setTimeout(() => {
                            const projectSummary = "Hi TimesTen Team! I'm interested in discussing " + 
                                "a project with you. Here's what I'm looking for: " + 
                                "[Please add your project details here]";
                            addWhatsAppButton(projectSummary);
                            
                            // Add alternative contact options
                            setTimeout(() => {
                                addMessage("You can also reach us through:", 'received');
                                const contactOptions = [
                                    { text: "Schedule Call", value: "schedule_call" },
                                    { text: "Send Email", value: "send_email" },
                                    { text: "Visit Office", value: "visit_office" }
                                ];
                                addCustomQuickReplies(contactOptions);
                            }, 1000);
                        }, 1000);
                    }, 1000);
                }, 1000);
                break;

            case 'quote_website':
            case 'quote_app':
            case 'quote_marketing':
            case 'quote_custom':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("Please select your budget range:", 'received');
                    const budgetOptions = [
                        { text: "KSH 35,000 - 50,000", value: "budget_basic" },
                        { text: "KSH 60,000 - 100,000", value: "budget_pro" },
                        { text: "KSH 100,000+", value: "budget_premium" },
                        { text: "Custom Budget", value: "budget_custom" }
                    ];
                    addCustomQuickReplies(budgetOptions);
                }, 1000);
                break;

            case 'budget_basic':
            case 'budget_pro':
            case 'budget_premium':
            case 'budget_custom':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("Great! Now, please select your preferred timeline:", 'received');
                    const timelineOptions = [
                        { text: "Urgent (1-2 weeks)", value: "timeline_urgent" },
                        { text: "Standard (3-4 weeks)", value: "timeline_standard" },
                        { text: "Flexible", value: "timeline_flexible" }
                    ];
                    addCustomQuickReplies(timelineOptions);
                }, 1000);
                break;

            case 'timeline_urgent':
            case 'timeline_standard':
            case 'timeline_flexible':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("Perfect! I have all the information needed for your quote. Would you like to:", 'received');
                    setTimeout(() => {
                        addMessage("1. Receive the quote on WhatsApp (Fastest)\n" +
                            "2. Schedule a call to discuss details\n" +
                            "3. Get the quote via email\n\n" +
                            "Choose your preferred option:", 'received');
                        const quoteDeliveryOptions = [
                            { text: "WhatsApp Quote", value: "quote_whatsapp" },
                            { text: "Schedule Call", value: "quote_call" },
                            { text: "Email Quote", value: "quote_email" }
                        ];
                        addCustomQuickReplies(quoteDeliveryOptions);
                    }, 1000);
                }, 1000);
                break;

            case 'quote_whatsapp':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("I'll connect you with our team on WhatsApp to receive your detailed quote immediately.", 'received');
                    setTimeout(() => {
                        const quoteSummary = "Hi TimesTen Team! I'd like to get a quote for my project with the following details:\n\n" +
                            "• Project Type: [Website/App/Marketing]\n" +
                            "• Budget Range: [Selected Budget]\n" +
                            "• Timeline: [Selected Timeline]\n\n" +
                            "Please provide me with a detailed quote. Thanks!";
                        addWhatsAppButton(quoteSummary);
                    }, 1000);
                }, 1000);
                break;

            case 'schedule_call':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("Let's schedule a call with our team to discuss your project in detail.", 'received');
                    setTimeout(() => {
                        addMessage("📞 Available Time Slots:\n\n" +
                            "• Morning (9 AM - 12 PM)\n" +
                            "• Afternoon (2 PM - 5 PM)\n" +
                            "• Custom Time\n\n" +
                            "Select your preferred time:", 'received');
                        const callTimeOptions = [
                            { text: "Morning Slot", value: "call_morning" },
                            { text: "Afternoon Slot", value: "call_afternoon" },
                            { text: "Custom Time", value: "call_custom" }
                        ];
                        addCustomQuickReplies(callTimeOptions);
                    }, 1000);
                }, 1000);
                break;

            case 'call_morning':
            case 'call_afternoon':
            case 'call_custom':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("Great! To schedule your call, please provide:", 'received');
                    setTimeout(() => {
                        addMessage("📅 Call Scheduling:\n\n" +
                            "• Your preferred date\n" +
                            "• Contact number\n" +
                            "• Brief project description\n\n" +
                            "Click below to share these details on WhatsApp and confirm your call:", 'received');
                        const callDetails = "Hi TimesTen Team! I'd like to schedule a call to discuss my project.\n\n" +
                            "Preferred Time: [Morning/Afternoon]\n" +
                            "Please contact me to confirm the exact time.\n\n" +
                            "Project Brief: [Your project details]";
                        addWhatsAppButton(callDetails);
                    }, 1000);
                }, 1000);
                break;

            case 'send_email':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("You can email us at info@timestentechnologies.co.ke", 'received');
                    setTimeout(() => {
                        addMessage("📧 For faster response, please include:\n\n" +
                            "• Project type\n" +
                            "• Budget range\n" +
                            "• Timeline\n" +
                            "• Your contact details\n\n" +
                            "Or continue on WhatsApp for immediate assistance:", 'received');
                        const emailAlternative = "Hi TimesTen Team! I'd like to discuss my project requirements.";
                        addWhatsAppButton(emailAlternative);
                    }, 1000);
                }, 1000);
                break;

            case 'visit_office':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("You're welcome to visit our office:", 'received');
                    setTimeout(() => {
                        addMessage("📍 TimesTen Technologies\n" +
                            "Location: [Your Office Address]\n" +
                            "Business Hours: Mon-Fri, 9 AM - 5 PM\n\n" +
                            "To ensure someone is available to assist you, please schedule your visit:", 'received');
                        const visitOptions = [
                            { text: "Schedule Visit", value: "schedule_visit" },
                            { text: "Get Directions", value: "get_directions" },
                            { text: "Talk on WhatsApp", value: "whatsapp_chat" }
                        ];
                        addCustomQuickReplies(visitOptions);
                    }, 1000);
                }, 1000);
                break;

            case 'schedule_visit':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("To schedule your office visit, please let us know:", 'received');
                    setTimeout(() => {
                        addMessage("🗓️ Visit Details Needed:\n\n" +
                            "• Preferred date and time\n" +
                            "• Number of people\n" +
                            "• Discussion topic\n\n" +
                            "Click below to schedule your visit via WhatsApp:", 'received');
                        const visitDetails = "Hi TimesTen Team! I'd like to schedule an office visit to discuss my project requirements.";
                        addWhatsAppButton(visitDetails);
                    }, 1000);
                }, 1000);
                break;

            case 'get_directions':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("Here's how to reach our office:", 'received');
                    setTimeout(() => {
                        addMessage("🚗 Directions to TimesTen Technologies:\n\n" +
                            "[Detailed directions to your office]\n\n" +
                            "Need help finding us? Click below to get live directions via WhatsApp:", 'received');
                        const directionsHelp = "Hi TimesTen Team! I need help with directions to your office.";
                        addWhatsAppButton(directionsHelp);
                    }, 1000);
                }, 1000);
                break;

            case 'quote_email':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("I'll help you get a detailed quote via email.", 'received');
                    setTimeout(() => {
                        addMessage("📧 To receive your quote:\n\n" +
                            "1. Email us at info@timestentechnologies.co.ke\n" +
                            "2. Subject: Quote Request - [Project Type]\n" +
                            "3. Include your requirements\n\n" +
                            "For faster response, click below to get your quote via WhatsApp:", 'received');
                        const quoteEmail = "Hi TimesTen Team! I'd like to get a quote for my project. Here are my requirements: [Your details]";
                        addWhatsAppButton(quoteEmail);
                    }, 1000);
                }, 1000);
                break;

            case 'quote_call':
                addTypingIndicator();
                setTimeout(() => {
                    removeTypingIndicator();
                    addMessage("Let's schedule a call to discuss your quote in detail.", 'received');
                    setTimeout(() => {
                        addMessage("📞 Available Time Slots:\n\n" +
                            "• Morning (9 AM - 12 PM)\n" +
                            "• Afternoon (2 PM - 5 PM)\n" +
                            "• Custom Time\n\n" +
                            "Select your preferred time:", 'received');
                        const quoteCallOptions = [
                            { text: "Morning", value: "call_morning" },
                            { text: "Afternoon", value: "call_afternoon" },
                            { text: "Custom Time", value: "call_custom" }
                        ];
                        addCustomQuickReplies(quoteCallOptions);
                    }, 1000);
                }, 1000);
                break;

            default:
                generateResponse(text);
        }
    }

    // Function to add custom quick replies
    function addCustomQuickReplies(buttons) {
        const quickReplyDiv = document.createElement('div');
        quickReplyDiv.className = 'chat-message received quick-replies';
        
        buttons.forEach(button => {
            const btn = document.createElement('button');
            btn.className = 'quick-reply-btn';
            btn.textContent = button.text;
            btn.onclick = () => handleQuickReply(button.value, button.text);
            quickReplyDiv.appendChild(btn);
        });
        
        chatBody.appendChild(quickReplyDiv);
        chatBody.scrollTop = chatBody.scrollHeight;
    }
});
</script> 