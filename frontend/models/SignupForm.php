<?php
namespace frontend\models;

use Yii;
use yii\rbac\DbManager;
use yii\base\Model;
use common\models\User;
use backend\models\AuthAssignment;

/**
 * Signup form
 */
class SignupForm extends Model
{
    public $first_name;
    public $last_name;
    public $username;
    public $email;
    public $password;
    public $permissions;


    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            ['username', 'filter', 'filter' => 'trim'],
            [['username', 'first_name', 'last_name'], 'required'],

            ['username', 'unique', 'targetClass' => '\common\models\User', 'message' => 'This username has already been taken.'],
            ['username', 'string', 'min' => 2, 'max' => 255],

            ['email', 'filter', 'filter' => 'trim'],
            ['email', 'required'],
            ['email', 'email'],
            ['email', 'string', 'max' => 255],
            ['email', 'unique', 'targetClass' => '\common\models\User', 'message' => 'This email address has already been taken.'],

            ['password', 'required'],
            ['password', 'string', 'min' => 6],
        ];
    }

    /**
     * Signs user up.
     *
     * @return User|null the saved model or null if saving fails
     */
    public function signup()
    {
        if (!$this->validate()) {
            return null;
        }

        $user = new User();
        $user->first_name = $this->first_name;
        $user->last_name = $this->last_name;
        $user->username = $this->username;
        $user->email = $this->email;
        $user->setPassword($this->password);
        $user->generateAuthKey();

        //add rule for new user
        // $auth = Yii::$app->authManager;
        // $authorRole = $auth->getRole('author');
        // $auth->assign($authorRole, $user->getId());

        if ($user->save()) {
            // lets add the permissions
            $permissionList = $_POST['SignupForm']['permissions'];

            if (is_array($permissionList)) {
                foreach ($permissionList as $value) {
                    $newPermission = new AuthAssignment;
                    $newPermission->user_id = $user->id;
                    $newPermission->item_name = $value;
                    $newPermission->save();
                }
            }


        }

        return $user;
    }
}
