using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MousePosition : MonoBehaviour
{
    Renderer render;

    // Start is called before the first frame update
    void Start()
    {
        render = GetComponent<Renderer>();

        render.material.shader = Shader.Find("Custom/HillFromTexture");
    }
    float timer = 0.0f;
    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.W))
        {
            print("hello");
        }
        while (Input.GetKey(KeyCode.W))
        {
            timer += Time.deltaTime;
            if (timer < 5.0f)
            {
                render.material.SetFloat("_DisplacementAmt", 1 + (timer * 0.1f));
            }
            else
            {
                break;
            }
        }
       
        
       

        // render.material.SetFloat("_mY", Input.mousePosition.y);


        //Debug.Log(Input.mousePosition);
    }
}
